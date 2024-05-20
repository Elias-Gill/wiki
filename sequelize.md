https://sequelize.org/docs/v6/core-concepts/model-basics/

# Examples 

## Table to class creation

Los tipos de datos de sequelize estan contenidos en `DataTypes`:

Ejemplo de creacion de un modelo que corresponde a una tabla utilizando `extends`

```js
import {
    Sequelize,
    DataTypes,
    Model,
    InferAttributes,
    InferCreationAttributes,
} from "sequelize";

const sequelize = new Sequelize("mysql://example:asd123@localhost:3306/mydb");

class User extends Model<InferAttributes<User>, InferCreationAttributes<User>> {
    declare firstName: DataTypes.IntegerDataType;

    // there is no need to use CreationOptional on lastName because nullable attributes
    // are always optional in User.create()
    declare lastName: string | null;
}

// you still have to define the schema configuration with
User.init(
    {
        firstName: {
            key: "columna",
            type: DataTypes.INTEGER,
            primaryKey: true,
            autoIncrement: true,
        },
        lastName: {
            key: "columna",
            type: DataTypes.STRING,
            validate: {
                len: [1, 30],
            }
        },
    },
    { sequelize, tableName: "Usuarios" }
);
```

## Contained classes

```js
class Project extends Model<
    InferAttributes<Project>,
    InferCreationAttributes<Project>
> {
    // id can be undefined during creation when using `autoIncrement`
    declare id: CreationOptional<number>;

    // foreign keys are automatically added by associations methods by branding 
    // them using the `ForeignKey` type, `Project.init` will know it does not need to
    // display an error if ownerId is missing.
    declare ownerId: ForeignKey<User['id']>;
    declare name: string;

    // `owner` is an eagerly-loaded association.
    // We tag it as `NonAttribute`
    declare owner?: NonAttribute<User>;

    // createdAt can be undefined during creation
    declare createdAt: CreationOptional<Date>;
}

// there is no need to initialize the owner, because it is currently initilized on
// its own class
Project.init( { 
    id: { 
        type: DataTypes.INTEGER.UNSIGNED, 
        autoIncrement: true, 
        primaryKey: true 
    }, 
    name: { 
        type: new DataTypes.STRING(128), 
        allowNull: false 
    }, 
    { sequelize, tableName: 'projects' } 
);
```

## Content management

first have to use the `build` method: 
```js
// this creates a new instance of the model. This is the "starting" point for our models
// management
const jane = await User.build({ name: 'Jane' });
// to create multiple instances use bulkCreate, which returns an array of instances
const captains = await Captain.bulkCreate([{ name: 'Jack Sparrow' }, { name: 'Davy Jones' }]);
```

For updating, adding or deleting instances in the database you can use the builtin commands:
```js
// Create is the combination of "build" and "save". So, now jane is inserted on the database
const jane = await User.create({ name: 'Jane' });
// with this instance we can use update, destroy (to delete), save and reload
await jane.update({ name: 'Olivia' });  // update just a specific parameter
await jane.destroy();                   // deletes the instance from the database
await jane.save();                      // persists ALL changes of the instance to the database
await jane.reload();                    // reload the original state of the table
```

Incrementing and decrementing fileds can be done with:
```js
// in postgres, increment has the new updated instance, with other drivers you need to use "reload"
const increment = await jane.increment('age', { by: 2 });       // single field
const increment = await jane.increment({age: 2, cash: 100});    // multi fields
const increment = await jane.increment(['age', 'cash'], { by: 2 }); // same value
```

## Select querys
```js
// suponiendo que las columnas son ['id', 'qux', 'hats']
Model.findAll({
    attributes: [
        'id', 'qux', 'hats',
        [sequelize.fn('COUNT', sequelize.col('hats')), 'n_hats'], // To add the aggregation...
    ],
});

// De manera mas corta
Model.findAll({
    attributes: {
        include: [[sequelize.fn('COUNT', sequelize.col('hats')), 'n_hats']],
    },
});

// Si queremos filtrar
Model.findAll({
    attributes: {
        exclude: ['qux'],
    },
});
```

For where clauses:
```js
const { Op } = require('sequelize');
Post.findAll({
    where: {
        [Op.and]: [{ authorId: 12 }, { status: 'active' }],
    },
});});
// SELECT * FROM post WHERE authorId = 12 AND status = 'active';
```

Advanced queries with functions (not just columns):

```js
Post.findAll({
  where: sequelize.where(sequelize.fn('char_length', sequelize.col('content')), 7),
});
// SELECT ... FROM "posts" AS "post" WHERE char_length("content") = 7
```

Deletes, updates, groups, ordering and pagination are done in a similar fashion.

Also is worth to know some examples of utilitie functions:

```js
await User.max('age'); // 40
await User.min('age', { where: { age: { [Op.lt]: 20 } } });
await User.sum('age'); // 55
await User.count(); // count all users
```

## Setters and getters

One important thing are setter and getters, that runs before any database operation.
You need to pass the custom method over the column:

NOTE:
use `validator` for data validation, setters for data manipulation before insertions.
```js
const User = sequelize.define('user', {
    username: DataTypes.STRING,
    password: {
        type: DataTypes.STRING,
        set(value) {
            // Hashing the value with an appropriate cryptographic hash function.
            this.setDataValue('password', hash(value));
        },
    },
});
```

## Virtual fields

Virtual fields are fields that Sequelize populates under the hood, but in reality they don't
even exist in the database.

```js
const User = sequelize.define('user', {
    firstName: DataTypes.TEXT,
    lastName: DataTypes.TEXT,
    fullName: {
        type: DataTypes.VIRTUAL,
        get() {
            return `${this.firstName} ${this.lastName}`;
        },
        set(value) {
            throw new Error('Do not try to set the `fullName` value!');
        },
    },
});
```

# Notes

- Para busquedas sobre claves primarias, contamos con una utilidad `FindByPk`

## About validate on columns

An object of validations to execute for this column every time the model is saved.
Can be either the name of a validation provided by validator.js, a validation function provided
by extending validator.js (see the `DAOValidator` property for more details), or a custom
validation function.
Custom validation functions are called with the value of the field, and can possibly take a
second callback argument, to signal that they are asynchronous.
If the validator is sync, it should throw in the case of a failed validation, it it is async,
the callback should be called with the error text.


| **Data Type**         | **Size (Bytes)** | **Range**                                                                |
|-----------------------|------------------|--------------------------------------------------------------------------|
| `char`                | 1                | -128 to 127 (signed) or 0 to 255 (unsigned)                              |
| `unsigned char`       | 1                | 0 to 255                                                                 |
| `short`               | 2                | -32,768 to 32,767 (signed) or 0 to 65,535 (unsigned)                     |
| `unsigned short`      | 2                | 0 to 65,535                                                              |
| `int`                 | 4                | -2,147,483,648 to 2,147,483,647 (signed)                                 |
| `unsigned int`        | 4                | 0 to 4,294,967,295                                                       |
| `long`                | 4 or 8           | -2,147,483,648 to 2,147,483,647 (4 bytes, 32-bit)                        |
| `unsigned long`       | 4 or 8           | 0 to 4,294,967,295 (4 bytes) or 0 to 1.8e19 (8 bytes)                    |
| `long long`           | 8                | -9.2e18 to 9.2e18 (signed) or 0 to 1.8e19 (unsigned)                     |
| `unsigned long long`  | 8                | 0 to 1.8e19                                                              |
| `float`               | 4                | ~1.2e-38 to 3.4e38 (6-7 decimal digits precision)                        |
| `double`              | 8                | ~2.3e-308 to 1.7e308 (15-16 decimal digits precision)                    |
| `long double`         | 8, 12, or 16     | Platform-dependent (often 10 or 16 bytes)                                |
| `void*` (pointer)     | 4 or 8           | 4 bytes (32-bit systems) or 8 bytes (64-bit systems)                     |

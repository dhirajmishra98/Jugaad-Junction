# Ecommerce Backend Server (Jugaad-Junction Server)

*This backend is also hosted on render.* <b>
There are two ways to utilize this backend service<b>

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)


**Prerequisites**
- Node.js
- MongoDB
<b>

## 1. If you are moving with Jugaad-Junction.
1. Install dependencies:
    ```bash
    cd server
    npm install
    ```

2. Configuration
- Create a `.env` file in the project root directory.
- Configure the environment variables in the `.env` file:
   ```bash
   MongoDB_KEY = "your_mongodb_key"
   jwtSecret_KEY = "your_jwt_scret_key"
  ```

4. Set up the MongoDB database:

- Create a new database in MongoDB.
- Set variable name in *.env* as in the example above, everything should work fine

5. Start the server:

    ```bash
    npm start
    ```

## 2. You can use this independent repository in your e-commerce app backend and modify it accordingly.

Follow This Repository: https://github.com/dhirajmishra98/Ecommerce-Backend-Server.git



















# Pizza Shop Server

👉 https://pizzashop-server.onrender.com/

This is the backend API for a pizza ordering app.

[Frontend Repo](https://github.com/Akki226/pizza-shop)

## How to Run Locally:
1. Clone this repo: `git clone git@github.com:Akki226/pizza-shop-server.git`
2. In the project folder, create a **'.env'** file and specify the following parameters within the file:<br>
    PORT = 3000<br>
    DB_URL = {*PostgreSQL database URL of your choice*}
3. Install dependencies: `npm install`
5. Initialize database: `npm run setup-db` 
6. Start the API: `npm run dev`
7. Access the API on [localhost:3000](http://localhost:3000/)
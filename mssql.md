Instructions on how to setup MSSQL on MacOS

# Resources
- website for installing MSSQL: https://database.guide/how-to-install-sql-server-on-a-mac/
- website for install Client interface: https://docs.microsoft.com/en-us/sql/azure-data-studio/download-azure-data-studio?view=sql-server-ver15

# Setting Up a local instance of MsSQL on your MacBook
- Install Docker on your macbook

- Run Docker

- Pull MSSQL image on to your server
  ```
  sudo docker pull mcr.microsoft.com/mssql/server:2019-latest
  ```

- run MSSQL on your MacBook in the background
  ```
  docker run -d --name sql_server_demo -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=SimplePassword' -p 1433:1433 mcr.microsoft.com/mssql/server:2019-latest
  ```

- Check to make sure Docker is running
  ```
  docker ps
  ```

- Install MSSQL command line interface using NPM  
  ```
  nvm use v14.15.1
  npm install -g sql-cli
  ```

- Login to MSSQL 
  User name is sa
  Password is SimplePassword  
  ```
  mssql -u sa -p SimplePassword  
  ```

- Download Graphical User Interface
  ```
  https://docs.microsoft.com/en-us/sql/azure-data-studio/download-azure-data-studio?view=sql-server-ver15
  ```

# Creating a new database and testing table

- Creating a new testing database and User Login Credentials
  ```
  CREATE DATABASE MyTestingDb;
  USE MyTestingDb;
  CREATE TABLE Inventory (
    Id int IDENTITY(1,1) NOT NULL PRIMARY KEY,
    manufacturing_number nvarchar(255),
    product_name nvarchar(255),
    manufacturer_number nvarchar(255),
    price float,
  );


  CREATE LOGIN tester123
    WITH PASSWORD = 'testing123!';  
  create user tester123 for login tester123;
  grant insert to tester123;
  grant select to tester123;

  ```


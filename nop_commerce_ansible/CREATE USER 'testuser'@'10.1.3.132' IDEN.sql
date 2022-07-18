CREATE USER 'testuser'@'10.1.3.140' IDENTIFIED BY 'testuser';

GRANT ALL PRIVILEGES ON *.* TO 'testuser'@'10.1.3.140' WITH GRANT OPTION;

 Server=10.0.2.174;Port=3306;Database=testuserdata;Uid=testuser;Pwd=testuser;

1.If you have installed mysql remotely Create new database user CREATE USER 'username'@'IPaddress' IDENTIFIED BY 'Password';
2.Add privileges for the user GRANT ALL PRIVILEGES ON *.* TO 'username'@'IPaddress' WITH GRANT OPTION;
3.install mysql-client in nop commerce installed server.
4.Try login into mysql remotely in command line and check whether you can able to login into created user or not.
5.If you are able to login remotely it will work.
6.Try using Connection string               Server=IPaddress;Port=3306;Database=databasename;Uid=username;Pwd=password;

CREATE USER 'testuser'@'10.0.2.174' IDENTIFIED BY 'testuser';


CREATE USER 'testuser'@'10.1.3.140' IDENTIFIED BY 'testuser';
GRANT ALL PRIVILEGES ON *.* TO 'testuser'@'10.1.3.140' WITH GRANT OPTION;

sudo mysql -h 10.0.2.174 -u testuser -p
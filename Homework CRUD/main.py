import pymysql
from config import host, password, db_name, user

try:
    connection = pymysql.connect(
        host = host, 
        port = 3306,
        user = user,
        password = password,
        database = db_name,
        cursorclass = pymysql.cursors.DictCursor
    )
    print("Connected")
    try:
        cursor = connection.cursor()

        cursor.execute("DROP TABLE IF EXISTS goods;")

        create_query = """CREATE TABLE IF NOT EXISTS goods
                        (
                            id INT PRIMARY KEY AUTO_INCREMENT,
                            product_name VARCHAR(45),
                            price DECIMAL(10,2),
                            quantity INT
                        );"""
        cursor.execute(create_query)
        print("Table created successfully!")

        insert_query = """INSERT goods(product_name, price, quantity)
                        VALUES
                            ("book", 29.99, 3),
                            ("pencil", 2.99, 15),
                            ("sketchbook", 15.99, 7);"""
        cursor.execute(insert_query)
        connection.commit() 

        cursor.execute("UPDATE goods SET price=25.99 WHERE id = 1;")
        connection.commit() 

        cursor.execute("DELETE FROM goods WHERE id = 3;")
        connection.commit() 

        cursor.execute("SELECT * FROM goods;")
        rows = cursor.fetchall()
        for row in rows:
            print(row)
        print(rows)
    finally:
        connection.close()
except Exception as ex:
    print(ex)
    print("Connection refused")

import mysql.connector as con


def connection():
    # Database connection details
    host = 'localhost'
    database = 'eyedetection'
    user = 'root'
    password = 'root'
    # Establish a connection to the database
    conn = con.connect(host=host, database=database, user=user, password=password ,charset='utf8')
    cur = conn.cursor()
    return conn ,cur
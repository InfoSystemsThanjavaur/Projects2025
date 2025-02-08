import mysql.connector

def get_db_connection():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="root",
        database="dual_server"
    )
def get_all_users():
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    
    query = "SELECT id, first_name, last_name, email, phone, address, gender, dob, username FROM users"
    cursor.execute(query)
    
    users = cursor.fetchall()
    conn.close()
    return users

def delete_user(user_id):
    conn = get_db_connection()
    cursor = conn.cursor()
    
    query = "DELETE FROM users WHERE id = %s"
    cursor.execute(query, (user_id,))
    
    conn.commit()
    conn.close()
    
    return f"User with ID {user_id} has been deleted successfully."




def update_user(user_id, first_name, last_name, email, phone, address, gender, dob, username):
    conn = get_db_connection()
    cursor = conn.cursor()

    query = """
        UPDATE users 
        SET first_name = %s, last_name = %s, email = %s, phone = %s, 
            address = %s, gender = %s, dob = %s, username = %s
        WHERE id = %s
    """
    values = (first_name, last_name, email, phone, address, gender, dob, username, user_id)
    
    cursor.execute(query, values)
    conn.commit()
    conn.close()
    
    return f"User with ID {user_id} has been updated successfully."


def search_user(search_value):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    
    query = "SELECT * FROM users WHERE email = %s OR username = %s"
    cursor.execute(query, (search_value, search_value))
    
    user = cursor.fetchone()
    conn.close()
    
    return user if user else "User not found."
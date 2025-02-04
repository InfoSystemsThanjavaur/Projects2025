import streamlit as st
from databasecon import connection
def login_page():
    st.title("Login Page")
    
    # Login Form
    username = st.text_input("Username or Email ")
    password = st.text_input("Password", type="password")
    login_button = st.button("Login")
    sql = "SELECT username FROM user WHERE email = %s or username=%s AND password = %s"
    val= (username,username,password)
    
    if login_button:
        
        try:
            con ,cur = connection()
            cur.execute(sql,val)
            data = cur.fetchall()
            if data:
        # Replace with your authentication logic
        
                st.session_state.is_logged_in = True
                st.session_state.username = data[0][0]
                st.success("Logged in successfully! Redirecting to Home...")
                
                # Redirect to Home page
                st.session_state.current_page = "Home"
            
            else:
                st.error("Invalid username or password.")
        except Exception as e:
            st.error("An error occurred: " + str(e))

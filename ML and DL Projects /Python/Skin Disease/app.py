import streamlit as st
from streamlit_option_menu import option_menu
from login import login_page
from signup import signup_page
from index import main_page

# Initialize session state variables
if "is_logged_in" not in st.session_state:
    st.session_state.is_logged_in = False
    st.session_state.username = ""
if "current_page" not in st.session_state:
    st.session_state.current_page = "Login"  # Default page for unauthenticated users

# Enhanced navigation menu
with st.sidebar:
    menu_selection = option_menu(
        "Navigation",
        ["Home", "Login", "Signup"],
        icons=["house", "box-arrow-in-right", "person-plus"],
        menu_icon="menu-app",  # Icon for the sidebar menu
        default_index=1 if st.session_state.current_page == "Login" else 0,
        styles={
            "container": {"padding": "5px", "background-color": "#f8f9fa"},
            "nav-link": {"font-size": "16px", "margin": "5px", "text-align": "left"},
            "nav-link-selected": {"background-color": "#007bff", "color": "white"},
        },
    )

# Update the session state based on menu selection
st.session_state.current_page = menu_selection

# Handle navigation
if st.session_state.current_page == "Home":
    if st.session_state.is_logged_in:
        main_page()
    else:
        st.warning("You must log in to access this page.")
elif st.session_state.current_page == "Login":
    login_page()
elif st.session_state.current_page == "Signup":
    signup_page()

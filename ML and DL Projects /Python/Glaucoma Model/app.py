import streamlit as st
from streamlit_option_menu import option_menu
from login import login_page
from signup import signup_page
from index import main_page

# Add custom CSS with a clear focus on aesthetics
st.markdown(
    """
    <style>
    /* Full-page background */
    .stApp {
        background: linear-gradient(to right, #ffecd2, #fcb69f); /* Subtle warm gradient */
        font-family: 'Arial', sans-serif;
    }
    /* Sidebar customization */
    .css-1d391kg {
        background-color: #2c3e50; /* Deep blue-gray */
        color: #ecf0f1; /* Light text for readability */
    }
    .css-1d391kg h1 {
        color: #f39c12; /* Highlighted orange for titles */
    }
    /* Navigation menu styling */
    .css-18e3th9 {
        background-color: #ffffff; /* White container */
        border-radius: 8px;
        box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1); /* Soft shadow */
    }
    .css-18e3th9:hover {
        background-color: #f1f1f1; /* Light hover effect */
    }
    .css-18e3th9 a {
        color: #34495e; /* Dark text color */
        font-size: 15px;
    }
    .css-18e3th9 a:hover {
        color: #2980b9; /* Vibrant blue hover */
    }
    /* Warnings and alerts */
    .st-alert {
        background-color: #ffe4e1; /* Soft pink alert box */
        border-left: 5px solid #e74c3c; /* Bold red border */
        padding: 10px;
        border-radius: 5px;
    }
    </style>
    """,
    unsafe_allow_html=True,
)

# Initialize session state variables
if "is_logged_in" not in st.session_state:
    st.session_state.is_logged_in = False
    st.session_state.username = ""
if "current_page" not in st.session_state:
    st.session_state.current_page = "Login"  # Default page for unauthenticated users

# Enhanced navigation menu
with st.sidebar:
    st.markdown("## My Modern App")  # Sidebar title
    menu_selection = option_menu(
        "Navigation",
        ["Home", "Login", "Signup"],
        icons=["house", "box-arrow-in-right", "person-plus"],
        menu_icon="menu-app",  # Icon for the sidebar menu
        default_index=1 if st.session_state.current_page == "Login" else 0,
        styles={
            "container": {"padding": "5px", "background-color": "#ffffff", "border-radius": "8px"},
            "nav-link": {"font-size": "16px", "margin": "5px", "text-align": "left", "color": "#34495e"},
            "nav-link-selected": {"background-color": "#2980b9", "color": "white"},
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

import sqlite3

def create_table():
    try:
        conn = sqlite3.connect('database.db')  # Connect to the SQLite database
        cursor = conn.cursor()  # Create a cursor object to execute SQL commands

        # SQL statement to create the 'users' table
        create_table_query = """
            CREATE TABLE IF NOT EXISTS users (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                name TEXT NOT NULL
            )
        """

        cursor.execute(create_table_query)  # Execute the SQL statement
        conn.commit()  # Commit the changes
        print("Table created successfully")

    except sqlite3.Error as e:
        print("Error creating table:", e)

    finally:
        conn.close()


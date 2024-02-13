from fastapi import FastAPI
import sqlite3
from pydantic import BaseModel
import uvicorn
from database import create_table

app = FastAPI()

@app.get("/")
async def root():
    return {"message": "Hello World"}

@app.get("/users")
async def users():
    conn = sqlite3.connect('database.db')
    c = conn.cursor()
    c.execute('SELECT * FROM users')
    users = c.fetchall()
    conn.close()

    formatted_users = []
    for user in users:
        formatted_users.append({'id': user[0], 'name': user[1]})  # Assuming id is at index 0 and name is at index 1

    return {"users": formatted_users}


class User(BaseModel):
    name: str

def create_user(user: User):
    conn = sqlite3.connect('database.db')
    c = conn.cursor()
    c.execute('INSERT INTO users (name) VALUES (?)', (user.name,))
    conn.commit()
    conn.close()



@app.post("/users")
async def create_user_route(user: User):
    create_user(user)
    return {"message": "User created successfully"}

def update_user(id: int, user: User):
    conn = sqlite3.connect('database.db')
    c = conn.cursor()
    c.execute('UPDATE users SET name = ? WHERE id = ?', (user.name, id))
    conn.commit()
    conn.close()

@app.put("/users/{id}")
async def update_user_route(id: int, user: User):
    update_user(id, user)
    return {"message": "User updated successfully"}

def delete_user(id: int):
    conn = sqlite3.connect('database.db')
    c = conn.cursor()
    c.execute('DELETE FROM users WHERE id = ?', (id,))
    conn.commit()
    conn.close()

@app.delete("/users/{id}")
async def delete_user_route(id: int):
    delete_user(id)
    return {"message": "User deleted successfully"}

if __name__ == "__main__":
    create_table()
    uvicorn.run(app, host="localhost", port=8000)
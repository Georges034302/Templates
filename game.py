# game.py
import random
import sqlite3

conn = sqlite3.connect("game.db")
cursor = conn.cursor()

cursor.execute("""
CREATE TABLE IF NOT EXISTS players (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    score INTEGER
)
""")

def add_10_players():
    for _ in range(10):
        score = random.randint(0, 100)
        cursor.execute(
            "INSERT INTO players (score) VALUES (?)",
            (score,)
        )
    conn.commit()

def show_scoreboard():
    cursor.execute("SELECT id, score FROM players")

    for player_id, score in cursor.fetchall():
        print(f"Player {player_id:03} — Score: {score}")

def show_top_3():
    cursor.execute("""
        SELECT id, score
        FROM players
        WHERE score BETWEEN 0 AND 100
        ORDER BY score DESC
        LIMIT 3
    """)

    print("\nTop 3 Players")

    for player_id, score in cursor.fetchall():
        print(f"Player {player_id:03} — Score: {score}")

add_10_players()
show_scoreboard()
show_top_3()

conn.close()

import os
import sqlite3

if __name__ == "__main__":
    temp_path = os.path.abspath("./beevenue/gitpod.sqlite")

    with open("demo.sql", "rb") as f:
        DEMO_SQL = f.read().decode("utf-8")

    escaped_temp_path = temp_path.replace("\\", "\\\\")
    conn = sqlite3.connect(escaped_temp_path)
    conn.executescript(DEMO_SQL)
    conn.commit()
    conn.close()

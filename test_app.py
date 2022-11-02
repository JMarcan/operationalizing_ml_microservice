import unittest
from app import app

class TestClass(unittest.TestCase):
    def test_homepage_access(self):
        with app.test_client() as client:
            res = client.get("/")

        self.assertEqual(res.status_code, 200)

if __name__ == '__main__':
    unittest.main()
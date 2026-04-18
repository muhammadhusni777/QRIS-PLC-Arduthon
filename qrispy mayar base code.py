from qrispy import Mayar

# Initialize the API client with your Mayar API Key

api = Mayar("eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiJiMTg5OWM0My01YjJkLTRlOGUtYmMyZS1jZDI2NGI3ZTE0ZDgiLCJhY2NvdW50SWQiOiI5NTIzNWFlYy1iNjJjLTQ0NjMtYjJlNC1kYzUwZWZkZWYyYWMiLCJjcmVhdGVkQXQiOiIxNzc2MzI3MDM2NTg5Iiwicm9sZSI6ImRldmVsb3BlciIsInN1YiI6Imh1c25pbXV0dGFxaW43NzdAZ21haWwuY29tIiwibmFtZSI6ImtlbGFzcm9ib3QiLCJsaW5rIjoiaHVzbmktbXV0dGFxaW4iLCJpc1NlbGZEb21haW4iOm51bGwsImlhdCI6MTc3NjMyNzAzNn0.Jbuaxfd0eDlgGwPHvDQc0HtIoPYqh1lbnj85MTVqzBb80mTZW3uWDRxI69NvTIG62fJ0egLKmTER9TXkz8M1Q4NajFvAHzE2NElk2qJSsM-QEcBhKvzrF7Zwupap3SfrSamqkt4qVv-dP19oo66cLKag32QmPNUab2_ZtdcQLefoldva6oTc1EQZRPvLA953zS3i6gtj42fJpDjWtm7-PIp0dXJTkWj51_Fdv_ENkr04oSC2cygnYHPOBUheYfaOYIpVlT45O6yH1jPxQt8gTR-RThsTUuywQu60fbggEhxc9f3H1MNx3Gch32K3-cnJBvGyuVmFr5kJPU207sEcmQ")
# Create a QRIS code
'''
qris = api.create_qris(10)  # amount in rupiah
if qris.status_code == 200:
    print(qris.url)  # QRIS image URL
else:
    print(f"Error: {qris.message}")
'''
# Check balance
balance = api.balance()
if balance.status_code == 200:
    print(f"Balance: {balance.balance}")
else:
    print(f"Error: {balance.message}")



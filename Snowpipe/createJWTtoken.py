import datetime
import json
import urllib
import threading
import jwt
import requests
from logging import getLogger
import time
import datetime
import os
from datetime import timedelta
from requests import HTTPError
import logging
from cryptography.hazmat.primitives import serialization
from cryptography.hazmat.primitives.serialization import load_pem_private_key
from cryptography.hazmat.backends import default_backend
from jwt.algorithms import RSAAlgorithm
from cryptography.hazmat.primitives.asymmetric import dsa, rsa

private_key = """
-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEA21Fp8NlErrFAKXTnPjdP5SkLzMkxgbxxuUS+1h4MlzXYSJxK
9QQjTC4PlYxcvxo0JSG9tisvfOu6yM08qt1DA5OGgd12Vuc/zjkRCxX8Mc4chGRH
jZP2ateMYBkd5QUsO8fEwGeAOzrhzknt2elcsuTRC8jMDEtZ0kZwywNWm7SQKsZq
pCnLiXHYivx+ftstjKsCJN5HzDiIUdnKK9pNUh2kXWy+BKH6tC2nRVW2zt8BstBk
tP5VgKJIGfUDcSJcohM4RpEVkd8dCwHOe47N6MD+XKlzZ/YxyuBBKVZInPy5evrG
Gd4Np5NyJWGX0GzqHGTPYKgmybzedMGciBGJlwIDAQABAoIBADHEz92v8D4USxMd
TDx6IM9H+T2Hiox+TvBUAVplh0XpGiOgFAJ15eyrpy2wpHtZXuvuNDbapfQbKk/X
AyVjAIoXODbQIsKlx3zsxklVu90xgJcqinI+WXT1ZQ2JpZcLDXajZqqi0h6exg8i
B6+jnT2bXzTlZCiGEOP+yCnJoCXE7/hrFP5LufSUExPW9AywbelJUvusC0QxIdPb
x9DvMsxRnU/NRoL0Qe3nW0Tyf+J5XTuIVigDbFR+cNSQSm2qM57KNq2UI8EM4DXy
ev4kALSC9iXHpfy+pOuV90k/IDkvzlykoFi2GpxjGW4S52HFtvyaPCQnBiPHNvGT
extdJIECgYEA/54XRvr1FAPNSyhKXXGb5ENdbjmg8nVHbyniEm8uktAQ/+S9ZqxX
U95CnUKi9IVP6edEbLNE9YWmjFK0+ukKa3YCeka5I+qM6NQR5T27JqcOyZ2bRRg9
XZJ0QTiW+Q0uvsZXypwTurFH2gQ4WcxvOKPobHH+zKd0ICU6YT2m6ekCgYEA26Vr
SyjZaW+ksie4vbOFnEuFADWeb6NLVNXvQRa/xQ0PF9jCyYBRLXouoj3ziVQA2F1r
/cjSxrZbWWccPxlvFuMeAXroCGyCPhS9N9zCdaw4JoyxKbEAi+KUb8Xyg1Ww7jw6
YDO61/IQ1JA3m5OrvmAXKG8WynSt6YmZd1n5J38CgYEAwEiY9AEF6Ldvb9DwF9jF
TvFJ0AezxY9pW/rin8FZBIFVuFjGDP0pd+Jis8+Tq2K5GZephidYgWS3QylYEMLK
3slX1clrrdPbia01hP9p0Aqs+gb/7Prt9nybzRAXqWM8PbAQDE5aHP8MsLip9wrs
w2uxBBrAdAynMyMuBkYNUDkCgYBv7DvfIaKfkm83BPyjVb4opWbRc4EXW/s/8H+p
CCGSFJRzT1X6fbNf3Bm1PKJDgRWpKvmjaVjWPwgPZ3ZCRQCRhgu9L1bbLAe2ALVm
qMxCUA6QvjJsjzA7F6sRxalM+TZePzxz1whHj6a52f8r/LSQHsDOLsVLRudz0FTu
N1+5mwKBgG0qtgJK18WxqgBOJXZNYXsn64QVmhO4c6k0HAB9VStgJn0wwyYoi9nI
uvTir+OA8DWkAmEUhLEO9PwRq5TcJoGAtiVh+8IknAdy/GM4O5Tiw3/Ox+ndP79n
M+RIhpUJUhqGvqQi8u3A6sdPN86ygm9xr11llM7mntyc4seaL5Xf
-----END RSA PRIVATE KEY-----"""

startDatetime = datetime.datetime.utcnow()
expireDatetime = startDatetime + datetime.timedelta(days=365)

payload = {
  'iss': 'UPMCHP.SNOWPIPE_USER.SHA256:H3rusKiWsWA+WIWpqym1/1/JQl0UThgA26poUkY3c8w=',
  'sub': 'UPMCHP.SNOWPIPE_USER',
  'iat': startDatetime,
  'exp': expireDatetime
  
}
encoded_jwt_token = jwt.encode(
   payload,
   private_key,
   'RS256')

print(encoded_jwt_token)
#print(str(encoded_jwt_token, "utf-8"))

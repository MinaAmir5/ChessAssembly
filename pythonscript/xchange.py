b = b''

with open("bn.bin", "rb") as file:
    while a := file.read(1):
        if a == b'\x02':
            b += b'\x06'
        elif a == b'\x01':
            b+=b'\x0f'
        else :
            b+=b'\x07'            

with open("bn2.bin", "wb") as file:
    file.write(b)
from PIL import Image

img = Image.open("flat_white.png").convert("RGBA")
datas = img.getdata()

newData = []
for item in datas:
    # item = (R, G, B, A)
    # jika warna putih (atau sangat terang)
    if item[0] > 240 and item[1] > 240 and item[2] > 240:
        # ubah jadi transparan
        newData.append((255, 255, 255, 0))
    else:
        newData.append(item)

img.putdata(newData)
img.save("output.png")
print("Background putih berhasil dibuat transparan!")

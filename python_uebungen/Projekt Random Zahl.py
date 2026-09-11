import random 

zahl = random.randint(1,100)
versuche = 0

print(zahl) # für Tests

while True:
    try:
        guess = int(input("Errate die Zahl. Welche Zahl nimmst du?"))
        break
    except:
        print("Eingabe war kein Int")

while (guess != zahl):
    versuche += 1

    if (guess > zahl):
        print("Zu Hoch!")

    if (guess < zahl):
        print("Zu Niedrig")

    while True:
        try:
             guess = int(input("Errate die Zahl. Welche Zahl nimmst du?"))
             break
        except:
            print("Eingabe war kein Int")


if (guess == zahl):
    print("Richtig!")
    print(f"Du hast {versuche} Versuche gebraucht")
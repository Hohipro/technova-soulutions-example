import random 

leicht = 100
mittel = 10000
schwer = 1000000

highscore = 0

while True: #unendlich schleife Spiel
    while True: #unendlich schleife für die Schwireikkeit
        try:
            schwierigkeit = input("Wähle deine Schwierigkeitsstufe! Leicht, Mittel oder Schwer?")

            if (schwierigkeit == "Leicht"):
                zahl = random.randint(1,leicht)
                break

            if (schwierigkeit == "Mittel"):
                zahl = random.randint(1,mittel)
                break

            if (schwierigkeit == "Schwer"):
                zahl = random.randint(1,schwer)
                break
            
            print("Schwierigkeitsstufe nicht erkannt!")
        except:
            print("Eingabe war fehlerhaft")

    while True: #schleife für das spiel 
        versuche = 1
        weiterspielen = input("Willst du starten oder die schwierigkeit wechseln? Anworte mit y für ja oder n für nein.")

        if (weiterspielen == "n"):
            break

        if (weiterspielen == "y"):
            try:
                if (schwierigkeit == "Leicht"):
                     zahl = random.randint(1,leicht)
                if (schwierigkeit == "Mittel"):
                     zahl = random.randint(1,mittel)
                if (schwierigkeit == "Schwer"):
                     zahl = random.randint(1,schwer)
                print(zahl) # für Tests

                while True: #Zahle abfrge schleife                
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
                    zähler = versuche

                if (zähler > highscore):
                    highscore = zähler
                    print(f"Dein Highscore ist {highscore}")
            except:
                print("Die Eingabe war fehlerhaft")
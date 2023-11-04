use context essentials2021
#For å kunne bruke RGB fargeverdier
include color
#For å importere Google regnearket hvor alle verdiene for de nordiske flaggene er ført inn. 
include gdrive-sheets

ssid = "1i3QCZkYfTlRZRhob1qlKu8BXvpmYCRUBij6VJoX6CxM"
#Full URL til Google sheet: https://docs.google.com/spreadsheets/d/1i3QCZkYfTlRZRhob1qlKu8BXvpmYCRUBij6VJoX6CxM/edit?usp=sharing

flag-data =
  load-table: country :: String, flag-length :: Number, flag-height :: Number, outer-cross-width :: Number, inner-cross-width :: Number, main-color-red :: Number, main-color-green :: Number, main-color-blue :: Number, main-color-alpha :: Number, outer-cross-color-red :: Number, outer-cross-color-green :: Number, outer-cross-color-blue :: Number, outer-cross-color-alpha :: Number, inner-cross-color-red :: Number, inner-cross-color-green :: Number, inner-cross-color-blue :: Number, inner-cross-color-alpha :: Number, x-outer-vertical :: Number, y-outer-vertical :: Number, x-outer-horizontal :: Number, y-outer-horizontal :: Number, x-inner-vertical :: Number, y-inner-vertical :: Number, x-inner-horizontal :: Number, y-inner-horizontal :: Number
    source: load-spreadsheet(ssid).sheet-by-name("flag-dimensions", true)
#Her er regnearket blitt lastet inn og definert som flag-data. Kilden tar utgangspunkt i SSIDen og to argumenter. "flag-dimensions" tilsvarer navnet til Sheetet(fanen) tabellen ligger på og true bestemmer at det er en header rad som skal ignoreres(altså, verdiene skal ikke medberegnes). 

#Tabellen er del opp i 7 rader, hvor den øverste blir header og de resterende tilsvarer hvert land. Videre består den av flere kolonner som tilsvarer verdier for størrelse på de nødvendige komponentene, RGB fargeverdiene samt x og y koordinatene for kryssene. Verdiene har tatt utgangspunkt i dimensjonene til hvert flagg ganget med 10 for enkelhets skyld (dette betyr at flaggene vil ha varierende størrelser) og RGB verdiene er hentet fra det som skal være sagt å være de korrekte. 
  end



  
fun printflagg(x):
#Funksjon for å bruke verdiene fra tabellen og lage alle flaggene. Radnummer er definert som x.  
  
#Bruker put-image funksjonen til å sette sammen komponentene fra tabellen. 
 
#Lager og plasserer den indre horisontale stripen
  put-image(
  rectangle(flag-data.row-n(x)["flag-length"], flag-data.row-n(x)["inner-cross-width"], "solid", color(flag-data.row-n(x)["inner-cross-color-red"], flag-data.row-n(x)["inner-cross-color-green"], flag-data.row-n(x)["inner-cross-color-blue"], flag-data.row-n(x)["inner-cross-color-alpha"])), flag-data.row-n(x)["x-inner-horizontal"], flag-data.row-n(x)["y-inner-horizontal"],
#Lager og plasserer den indre vertikale stripen      
  put-image(rectangle(flag-data.row-n(x)["inner-cross-width"], flag-data.row-n(x)["flag-height"], "solid", color(flag-data.row-n(x)["inner-cross-color-red"], flag-data.row-n(x)["inner-cross-color-green"], flag-data.row-n(x)["inner-cross-color-blue"], flag-data.row-n(x)["inner-cross-color-alpha"])), flag-data.row-n(x)["x-inner-vertical"], flag-data.row-n(x)["y-inner-vertical"],
#Lager og plasserer den ytre horisontale stripen 
    put-image(rectangle(flag-data.row-n(x)["flag-length"], flag-data.row-n(x)["outer-cross-width"], "solid", color(flag-data.row-n(x)["outer-cross-color-red"], flag-data.row-n(x)["outer-cross-color-green"], flag-data.row-n(x)["outer-cross-color-blue"], flag-data.row-n(x)["outer-cross-color-alpha"])), flag-data.row-n(x)["x-outer-horizontal"], flag-data.row-n(x)["y-outer-horizontal"],
#Lager og plasserer den ytre vertikale stripen  
      put-image(rectangle(flag-data.row-n(x)["outer-cross-width"], flag-data.row-n(x)["flag-height"], "solid", color(flag-data.row-n(x)["outer-cross-color-red"], flag-data.row-n(x)["outer-cross-color-green"], flag-data.row-n(x)["outer-cross-color-blue"], flag-data.row-n(x)["outer-cross-color-alpha"])), flag-data.row-n(x)["x-outer-vertical"], flag-data.row-n(x)["y-outer-vertical"],
#Lager bakgrunnen til flagget som de andre komponentene blir plassert over.
          rectangle(flag-data.row-n(x)["flag-length"], flag-data.row-n(x)["flag-height"], "solid", color(flag-data.row-n(x)["main-color-red"], flag-data.row-n(x)["main-color-green"], flag-data.row-n(x)["main-color-blue"], flag-data.row-n(x)["main-color-alpha"]))))))

     
  
  
end
#Ulempen med å gjøre det på denne måten er at linjene blir veldig store og vanskelige å lese, men til gjengjeld er koden blitt ganske kort. I tillegg er det veldig enkelt å endre på verdier da dette bare kan gjøres i selve regnearket istedenfor i koden. En annen ulempe er også det at regnearket må være tilgjengelig i Google Drive for at koden skal virke. 


fun flagg(land):
#Funksjonen som skal brukes til å returnere flaggene i konsollen. Avhengig av hvilket land som skrives inn defineres x til riktig radnummer for det respektive landet fra tabellen. Deretter caller den funksjonen printflag(x) og et flagg returneres. 
  
  if land == "norge":
    x = 0
    printflagg(x)
  else if land == "danmark": 
    x = 1 
    printflagg(x)
  else if land == "sverige":
    x = 2
    printflagg(x)
  else if land == "finland":
    x = 3
    printflagg(x)
  else if land == "island":
    x = 4 
    printflagg(x)
  else if land == "faeroyene":
    x = 5
    printflagg(x)
   
  end

end

#Definerer funksjonene med parametrene for hvert land for at det skal være enklere å føre det inn i konsollen
norge = flagg("norge")
danmark = flagg("danmark")
sverige = flagg("sverige")
finland = flagg("finland")
island = flagg("island")
faeroyene = flagg("faeroyene")

#Muligheten for å bruke stor førstebokstav
Norge = norge
Danmark = danmark
Sverige = sverige
Finland = finland
Island = island
Faeroyene = faeroyene

intro = ```Skriv inn ett av disse landene for å tegne flagget: 
        - Norge 
        - Danmark 
        - Sverige 
        - Finland 
        - Island 
        - Faeroyene```

print(intro)


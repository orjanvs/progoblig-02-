use context essentials2021
include shared-gdrive("dcic-2021", "1wyQZj_L0qqV9Ekgr9au6RX2iqt2Ga8Ep")
include gdrive-sheets
include data-source
include option

ssid = "1RYN0i4Zx_UETVuYacgaGfnFcv4l9zd9toQTTdkQkj7g"
kWh-wealthy-consumer-data =
load-table: komponent, energi
source: load-spreadsheet(ssid).sheet-by-name("kWh", true)
      #konverterer hva som helst til string.
    sanitize energi using string-sanitizer
      #Ifølge dokumentasjonen  er sanititze den eneste måten å sørge for at pyret tolker verdiene riktig.
end


#Funksjon for å regne ut energibruk per dag
fun energy-per-day(distance-travelled-per-day, distance-per-unit-of-fuel):
  
  ( distance-travelled-per-day / 
    distance-per-unit-of-fuel ) * 10 #kWh per liter (energy-per-unit-of-fuel)
  
end

#Tar utgangspunkt i verdier fra Norge, da dette nevnes tidligere i oppgavebeskrivelsen. Disse er hentet fra denne artikkelen på forskning.no (https://forskning.no/klima-forurensning/stemmer-det-at-utslippene-fra-et-containerskip-tilsvarer-50-millioner-biler/287052). For drivstofforbruket ble verdier fra artikkelen ført inn i en drivstoffkalkulator for å finne (https://www.kalkuler.com/kalkulator/penger/bensinpriskalkulator/). Verdien ble rundt opp for enkelhets skyld.   
energy-per-day-car = energy-per-day(38, 25) 



#Funksjon for å konvertere string til nummer
fun energi-to-number(str :: String) -> Number:
  
  cases(Option) string-to-number(str):
    | some(a) => a
    | none => energy-per-day-car
  end
  
where:
  energi-to-number("") is energy-per-day-car
energi-to-number("48") is 48
end

#Bruker funksjon for å endre verdiene i kolonne "energi" fra string til number.   
kWh-wealthy-consumer-data-numbers = transform-column(kWh-wealthy-consumer-data, "energi", energi-to-number)

#Summerer verdiene i kolonne "energi"
energi-sum = sum(kWh-wealthy-consumer-data-numbers, "energi")


#Produserer et stolpediagram basert på verdiene fra tabellen
stolpediagram = bar-chart(kWh-wealthy-consumer-data-numbers, "komponent", "energi")


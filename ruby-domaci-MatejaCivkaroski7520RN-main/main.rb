require './kolokvijum.rb'

# Creates a session. This will prompt the credential via command line for the
# first time and save it to config.json file for later usages.
# See this document to learn how to create config.json:
# https://github.com/gimite/google-drive-ruby/blob/master/doc/authorization.md
session = GoogleDrive::Session.from_config("config.json")

# First worksheet of
# https://docs.google.com/spreadsheet/ccc?key=pz7XtlQC-PYx-jrVMJErTcg
# Or https://docs.google.com/a/someone.com/spreadsheets/d/pz7XtlQC-PYx-jrVMJErTcg/edit?usp=drive_web
ws = session.spreadsheet_by_key("1YwSATe8w4fjLl_bv5iW1Ug17wAhK5BVZtHFM8pR2HQ0").worksheets[0]
ws2 = session.spreadsheet_by_key("1YwSATe8w4fjLl_bv5iW1Ug17wAhK5BVZtHFM8pR2HQ0").worksheets[1]
pr1=Probna.new(ws)
puts"Vracanje reda"
niz1=pr1.row(1)
p niz1
puts"Vracanje cele tabele"
pr1.print()
puts"Vracanje kolone"
puts pr1["prvaKolona"]
puts"menjanje vrednosti celije"
pr1["prvaKolona"][1]="abcdefg"
puts pr1["prvaKolona"][1]
puts"suma"
pr1.drugaKolona.sum
puts"avg"
pr1.drugaKolona.avg
puts "map"
pr1.prvaKolona.map { |cell| cell+=1 }
puts "select"
pr1.prvaKolona.select { |cell| cell%2==0 }
puts "reduce"
pr1.prvaKolona.reduce(:+) 
pr1.drugaKolona.ewr
pr2=Probna.new(ws2)
pr3=pr1+pr2
p pr3.mat
pr3=pr1-pr2
p pr3.mat
#napravi kolonu u konstruktoru
#napravi to_s metodu koja stampa kolonu
#ako u def [] prosledis string setujes kolonu a ako je broj onda wracas ws
ws.reload
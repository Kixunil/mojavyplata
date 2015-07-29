# mojavyplata

Sucasna verzia je polofunkcna, velmi jednoducha a web rozhranie nepodporuje upload priamo PDF suborov, ale je mozne uploadnut iba XML subor.

XML subor je mozne vygenerovat nasledovne:

`pdftotext -raw hour_vyplatne_pasky.pdf – |  sed -r -e ‘s/[0-9] – ([a-zA-Z].+)/\n\1/g’ -e ‘s/[0-9] [A-Z]/\n/g’  | parsers/hour_software.awk > payroll.xml`

Nasledne je mozne tento XML subor uploadnut do web rozhrania.

Implementovane parsery mzdovych softverov:

- Hour Software 

## Web rozhranie

Pre rozbehanie web rozhrania je nutne nainstalovat tieto baliky (plati pre systemy s Ubuntu):

apt:
- python-django

python baliky:
- pip install django-bootstrap3
- pip install easy\_pdf
- pip install django-easy-pdf
- pip install xhtml2pdf
- pip install xmltodict

Nasledne v adresari mojavyplata spustit:

 `mojavyplata$ python manage.py runserver 127.0.0.1:8000`

Na localhoste na porte 8000 je mozne spustit web rozhranie kam je mozne uploadnut XML subor ktory nakoniec vygeneruje PDF subor.

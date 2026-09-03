# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models


class Camera(models.Model):
    pk = models.CompositePrimaryKey('piano', 'numeroCamera')
    tipologia = models.CharField(max_length=15)
    numeromassimoospiti = models.DecimalField(db_column='numeroMassimoOspiti', max_digits=2, decimal_places=0)  # Field name made lowercase.
    piano = models.DecimalField(max_digits=2, decimal_places=0)
    descrizione = models.CharField(max_length=200)
    stato = models.CharField(max_length=12)
    prezzobasenotte = models.DecimalField(db_column='prezzoBaseNOTte', max_digits=8, decimal_places=2)  # Field name made lowercase.
    numerocamera = models.DecimalField(db_column='numeroCamera', max_digits=3, decimal_places=0)  # Field name made lowercase.
    attivo = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'CAMERA'
        unique_together = (('piano', 'numerocamera'),)


class Include(models.Model):
    pk = models.CompositePrimaryKey('codicePrenotazione', 'nomeServizio')
    nomeservizio = models.ForeignKey('ServizioAggiuntivo', models.DO_NOTHING, db_column='nomeServizio')  # Field name made lowercase.
    codiceprenotazione = models.ForeignKey('Prenotazione', models.DO_NOTHING, db_column='codicePrenotazione')  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'INCLUDE'
        unique_together = (('codiceprenotazione', 'nomeservizio'),)


class Occupante(models.Model):
    pk = models.CompositePrimaryKey('codicePrenotazione', 'documentoIdentita')
    codiceprenotazione = models.ForeignKey('Prenotazione', models.DO_NOTHING, db_column='codicePrenotazione')  # Field name made lowercase.
    nome = models.CharField(max_length=25)
    cognome = models.CharField(max_length=25)
    documentoidentita = models.CharField(db_column='documentoIdentita', max_length=9)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'OCCUPANTE'
        unique_together = (('codiceprenotazione', 'documentoidentita'),)


class Ospite(models.Model):
    nome = models.CharField(max_length=25)
    cognome = models.CharField(max_length=25)
    telefono = models.CharField(max_length=15)
    e_mail = models.CharField(unique=True, max_length=50)
    password = models.CharField(max_length=16)
    documentoidentita = models.CharField(db_column='documentoIdentita', primary_key=True, max_length=9)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'OSPITE'


class Pagamento(models.Model):
    codicepagamento = models.DecimalField(db_column='codicePagamento', primary_key=True, max_digits=6, decimal_places=0)  # Field name made lowercase.
    codiceprenotazione = models.OneToOneField('Prenotazione', models.DO_NOTHING, db_column='codicePrenotazione')  # Field name made lowercase.
    importototale = models.DecimalField(db_column='importoTotale', max_digits=8, decimal_places=2)  # Field name made lowercase.
    metodo = models.CharField(max_length=20)
    data = models.DateField()

    class Meta:
        managed = False
        db_table = 'PAGAMENTO'


class Personale(models.Model):
    nome = models.CharField(max_length=25)
    cognome = models.CharField(max_length=25)
    telefono = models.CharField(max_length=15)
    e_mail = models.CharField(unique=True, max_length=50)
    password = models.CharField(max_length=16)
    documentoidentita = models.CharField(db_column='documentoIdentita', primary_key=True, max_length=9)  # Field name made lowercase.
    ruolo = models.CharField(max_length=25)
    attivo = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'PERSONALE'


class Prenotazione(models.Model):
    codiceprenotazione = models.DecimalField(db_column='codicePrenotazione', primary_key=True, max_digits=6, decimal_places=0)  # Field name made lowercase.
    dataarrivo = models.DateField(db_column='dataArrivo')  # Field name made lowercase.
    datapartenza = models.DateField(db_column='dataPartenza')  # Field name made lowercase.
    numeroospiti = models.DecimalField(db_column='numeroOspiti', max_digits=2, decimal_places=0)  # Field name made lowercase.
    stato = models.CharField(max_length=12)
    datacheckineffettivo = models.DateField(db_column='dataCheckInEffettivo', blank=True, null=True)  # Field name made lowercase.
    documentoidentitaospite = models.ForeignKey(Ospite, models.DO_NOTHING, db_column='documentoIdentitaOspite')  # Field name made lowercase.
    piano = models.ForeignKey(Camera, models.DO_NOTHING, db_column='piano')
    numerocamera = models.ForeignKey(Camera, models.DO_NOTHING, db_column='numeroCamera', to_field='numeroCamera', related_name='prenotazione_numerocamera_set')  # Field name made lowercase.
    datainiziostagione = models.ForeignKey('Stagione', models.DO_NOTHING, db_column='dataInizioStagione', blank=True, null=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'PRENOTAZIONE'


class Pulizia(models.Model):
    pk = models.CompositePrimaryKey('piano', 'numeroCamera', 'data')
    piano = models.ForeignKey(Camera, models.DO_NOTHING, db_column='piano')
    numerocamera = models.ForeignKey(Camera, models.DO_NOTHING, db_column='numeroCamera', to_field='numeroCamera', related_name='pulizia_numerocamera_set')  # Field name made lowercase.
    data = models.DateField()
    documentoidentitaaddetto = models.ForeignKey(Personale, models.DO_NOTHING, db_column='documentoIdentitaAddetto')  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'PULIZIA'
        unique_together = (('piano', 'numerocamera', 'data'),)


class Recensione(models.Model):
    codicerecensione = models.DecimalField(db_column='codiceRecensione', primary_key=True, max_digits=6, decimal_places=0)  # Field name made lowercase.
    codiceprenotazione = models.OneToOneField(Prenotazione, models.DO_NOTHING, db_column='codicePrenotazione')  # Field name made lowercase.
    voto = models.DecimalField(max_digits=2, decimal_places=0)
    commento = models.CharField(max_length=300, blank=True, null=True)
    data = models.DateField()

    class Meta:
        managed = False
        db_table = 'RECENSIONE'


class ServizioAggiuntivo(models.Model):
    nome = models.CharField(primary_key=True, max_length=20)
    descrizione = models.CharField(max_length=200)
    costo = models.DecimalField(max_digits=5, decimal_places=2)
    attivo = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'SERVIZIO_AGGIUNTIVO'


class Stagione(models.Model):
    nome = models.CharField(max_length=20)
    moltiplicatore = models.DecimalField(max_digits=3, decimal_places=2)
    datainizio = models.DateField(db_column='dataInizio', primary_key=True)  # Field name made lowercase.
    datafine = models.DateField(db_column='dataFine')  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'STAGIONE'
# Generated by Django 2.2 on 2019-04-16 13:20

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [("will_of_the_prophets", "0004_specialsquaretype_auto_move")]

    operations = [
        migrations.AddField(
            model_name="butthole",
            name="end",
            field=models.DateTimeField(blank=True, null=True, verbose_name="end"),
        ),
        migrations.AddField(
            model_name="butthole",
            name="start",
            field=models.DateTimeField(blank=True, null=True, verbose_name="start"),
        ),
        migrations.AddField(
            model_name="specialsquare",
            name="end",
            field=models.DateTimeField(blank=True, null=True, verbose_name="end"),
        ),
        migrations.AddField(
            model_name="specialsquare",
            name="start",
            field=models.DateTimeField(blank=True, null=True, verbose_name="start"),
        ),
    ]

from django.db import models
from django.db.models.signals import post_save
from django.contrib.auth.models import User

class Account(models.Model):

    user = models.OneToOneField(User)
    phone = models.CharField(max_length=20)
    billing_street = models.CharField(max_length=100)
    billing_city = models.CharField(max_length=100)
    billing_postcode = models.CharField(max_length=12)
    billing_country = models.CharField(max_length=50)

    def __unicode__(self):
        return "%s" % (self.user,)


def create_user_account(sender, instance, created, **kwargs):
    if created:
        Account.objects.create(user=instance)

post_save.connect(create_user_account, sender=User)




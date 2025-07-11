import click
from utils.helpers import capitalize_all, add_numbers, example_decorated_function

@click.group()
def cli():
    """
    Un exemple de script Python avec des utilitaires de texte et de calcul.
    """
    pass

@cli.command()
@click.argument('text')
def capitalize(text):
    """
    Met en majuscules toutes les lettres d'une phrase.
    """
    click.echo(f"Texte original : {text}")
    click.echo(f"Texte capitalisé : {capitalize_all(text)}")

@cli.command()
@click.argument('numbers', nargs=-1, type=float)
def sum_numbers(numbers):
    """
    Calcule la somme d'une liste de nombres.
    Exemple : python main.py sum-numbers 10 20 5.5
    """
    if not numbers:
        click.echo("Veuillez fournir au moins un nombre à additionner.")
        return
    click.echo(f"Nombres à additionner : {list(numbers)}")
    click.echo(f"Somme : {add_numbers(list(numbers))}")

@cli.command()
@click.option('--message', default="Bonjour le monde !", help="Un message pour la fonction décorée.")
def run_decorated(message):
    """
    Exécute la fonction décorée pour démontrer son fonctionnement.
    """
    example_decorated_function(message)

if __name__ == "__main__":
    cli()
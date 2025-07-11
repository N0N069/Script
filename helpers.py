import functools

def capitalize_all(text: str) -> str:
    """
    Met en majuscules toutes les lettres d'une phrase.

    Args:
        text (str): La phrase à formater.

    Returns:
        str: La phrase avec toutes les lettres en majuscules.
    """
    return text.upper()

def add_numbers(numbers: list[int | float]) -> int | float:
    """
    Calcule la somme d'une liste de nombres.

    Args:
        numbers (list): Une liste de nombres (entiers ou flottants).

    Returns:
        int | float: La somme des nombres.
    """
    return sum(numbers)

def log_execution(func):
    """
    Décorateur qui affiche un message avant et après l'exécution d'une fonction.
    """
    @functools.wraps(func)
    def wrapper(*args, **kwargs):
        print(f"--- Début de l'exécution de '{func.__name__}' ---")
        result = func(*args, **kwargs)
        print(f"--- Fin de l'exécution de '{func.__name__}' ---")
        return result
    return wrapper

@log_execution
def example_decorated_function(message: str):
    """
    Une fonction d'exemple décorée pour démontrer le fonctionnement de log_execution.
    """
    print(f"Fonction exécutée avec le message : {message}")
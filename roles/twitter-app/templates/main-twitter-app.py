import oauth2
import json
import urllib.parse
import sys

# consumer auth
consumer_key='{{ consumer_key }}'
consumer_secret='{{ consumer_secret }}'

# token auth
token_key='{{ token_key }}'
token_secret='{{ token_secret }}'

# Criando autenticacao
consumer = oauth2.Consumer(consumer_key, consumer_secret)
token = oauth2.Token(token_key, token_secret)
client = oauth2.Client(consumer, token)

# Criando pesquisa
#query = input("Pesquisa: ")
query = sys.argv[1]
# Codificando caracteres especiais
query_codificada = urllib.parse.quote(query, safe='')

# Realizando pesquisa na API
requisicao = client.request('https://api.twitter.com/1.1/search/tweets.json?q=' + query_codificada)
#requisicao = client.request('https://api.twitter.com/1.1/search/tweets.json?q=' + query_codificada + '&lang=pt')

# Filtrando campos
decodificar = requisicao[1].decode()

# Convertendo json em objeto
objeto = json.loads(decodificar)

# Criadno lista de objeto com twitts
twittes = objeto['statuses']

# Exibindo twittes com o nome do usuario
for twit in twittes:
    print(twit['user']['screen_name'])
    print(twit['text'])
    print()

import requests
from bs4 import BeautifulSoup
import csv

def scrape_hacker_news():
    url = "https://news.ycombinator.com/"
    response = requests.get(url)
    if response.status_code == 200:
        soup = BeautifulSoup(response.text, 'html.parser')
        titles = soup.find_all('a', class_='storylink')
        return [title.text for title in titles]
    else:
        print("Failed to retrieve page:", response.status_code)
        return []

def save_to_csv(titles):
    with open('hacker_news_titles.csv', 'w', newline='', encoding='utf-8') as csvfile:
        fieldnames = ['Title']
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        
        writer.writeheader()
        for title in titles:
            writer.writerow({'Title': title})

if __name__ == "__main__":
    titles = scrape_hacker_news()
    if titles:
        save_to_csv(titles)
        print("Titles saved to hacker_news_titles.csv")
    else:
        print("No titles found.")
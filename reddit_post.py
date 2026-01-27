import requests
import random
import sys
from dataclasses import dataclass
from typing import Optional

REDDIT_API = "https://www.reddit.com/r/"
USER_AGENT = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36"

@dataclass
class RedditPost:
    subreddit: str
    title: str
    description: str
    url: str
    media_url: str
    author: str
    score: int
    upvotes: int
    downvotes: int

def get_random_reddit_post(sub_reddit: str) -> Optional[RedditPost]:
    url = f"{REDDIT_API}{sub_reddit}.json"
    headers = {
        "User-Agent": USER_AGENT,
        "Accept": "application/json"
    }

    try:
        response = requests.get(url, headers=headers)
        response.raise_for_status()
        
        data = response.json()
        posts_data = data["data"]["children"]
        total_posts = len(posts_data)
        
        print(f"Total posts found: {total_posts}")

        if total_posts == 0:
            print("No posts found in the subreddit.")

        random_index = random.randint(0, total_posts - 1)
        print(f"Selected post index: {random_index}")

        post = posts_data[random_index]["data"]

        return RedditPost(
            title=post.get("title"),
            subreddit=post.get("subreddit"),
            description=post.get("selftext"),
            media_url=post.get("url"),
            url=f"https://reddit.com{post.get('permalink')}",
            author=post.get("author"),
            score=post.get("score"),
            upvotes=post.get("ups"),
            downvotes=post.get("downs")
        )
    except Exception as error:
        print(f"Error fetching data: {error}")

if __name__ == "__main__":
    sub_reddit = input("Sub reddit to get a random post: ").strip()
    
    random_post = get_random_reddit_post(sub_reddit)

    if random_post is None:
        print("Failed to retrieve a post.")
    else:
        print(f"Title: {random_post.title}")
        print(f"Subreddit: {random_post.subreddit}")
        print(f"Author: {random_post.author}")
        print(f"Score: {random_post.score}")
        print(f"Upvotes: {random_post.upvotes}")
        print(f"Downvotes: {random_post.downvotes}")
        print(f"Media URL: {random_post.media_url}")
        print(f"URL: {random_post.url}")

        if random_post.description:
            print(f"Description: {random_post.description}")
        else:
            print("No description available.")
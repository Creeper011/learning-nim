import std/strutils
import httpclient
import json
import random

const redditAPI = "http://www.reddit.com/r/"

stdout.write("Sub reddit to get a random post: ")
stdout.flushFile()
let subReddit: string = readLine(stdin)

randomize() # this make a new seed for random number generation

type 
    RedditPost = object
        subreddit: string
        title: string
        description: string
        url: string
        mediaUrl: string
        author: string
        score: int
        upvotes: int
        downvotes: int

proc getRandomRedditPost(subReddit: string): RedditPost =
    let url = redditAPI & subReddit & ".json"
    var client = newHttpClient(
      headers = newHttpHeaders({
        "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
        "Accept": "application/json"
      })
    )

    let response = client.getContent(url)
    
    var posts = parseJson(response)
    let postsData = posts["data"]["children"]
    let totalPosts = postsData.len()
    echo "Total posts found: ", totalPosts

    if totalPosts == 0:
        echo "No posts found in the subreddit."
        quit(1)

    let randomIndex = rand(totalPosts)
    echo "Selected post index: ", randomIndex

    let post = postsData[randomIndex]["data"]
    result.title = post["title"].getStr()
    result.subreddit = post["subreddit"].getStr()
    result.description = post["selftext"].getStr()
    result.mediaUrl = post["url"].getStr()
    result.url = "https://reddit.com" & post["permalink"].getStr()
    result.author = post["author"].getStr()
    result.score = post["score"].getInt()
    result.upvotes = post["ups"].getInt()
    result.downvotes = post["downs"].getInt()

let randomPost = getRandomRedditPost(subReddit)

echo "Title: ", randomPost.title # using the comma avoids creating a third string for concatenation...  i think
echo "Subreddit: ", randomPost.subreddit
echo "Author: ", randomPost.author
echo "Score: ", randomPost.score
echo "Upvotes: ", randomPost.upvotes
echo "Downvotes: ", randomPost.downvotes
echo "Media URL: ", randomPost.mediaUrl
echo "URL: ", randomPost.url

if randomPost.description.len > 0:
    echo "Description: ", randomPost.description
else:
    echo "No description available."
# axolla

### TLDR;

My experience with [axel](https://github.com/eribertomota/axel) was a disaster, so I created **axolla**.


### Usage

```bash
./axolla.sh [OPTIONS] url1 [url2] [url...]
```

### Why ?

Sometimes when you try to download a file using `axel`, it breaks in the middle of the process.  
At these times you have to terminate the process with `Ctrl + C`, then restart it to resume the download process.  

You can use **axolla** to solve this problem.  
It uses `axel` and passes the parameters to it, then watches the output of `axel`. If the output doesn't change in a while, it kills axel and restarts the download process.

* Cleanup:
  * `docker system prune -f`
* List dangling volumes
  * `docker volume ls -qf dangling=true`
  * #carefull with this one :)
    * `docker volume rm $(docker volume ls -qf dangling=true)`
* List all volumes
  * `docker volume ls`
* Leave compose running
  * `entrypoint: ["sh", "-c", "sleep 2073600"]
`

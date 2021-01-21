* Cleanup:
  * docker system prune -f
  * #carefull with this one :)
  * docker volume rm $(docker volume ls -qf dangling=true)
* List dangling volumes
  * docker volume ls -qf dangling=true
* List all volumes
  * docker volume ls

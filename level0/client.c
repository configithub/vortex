#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>
#include <netdb.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <sys/socket.h>

#include <arpa/inet.h>

#define PORT "5842" // the port client will be connecting to 

#define MAXDATASIZE 10000 // max number of bytes we can get at once 

// get sockaddr, IPv4 or IPv6:
void *get_in_addr(struct sockaddr *sa) {
  if (sa->sa_family == AF_INET) {
    return &(((struct sockaddr_in*)sa)->sin_addr);
  }
  return &(((struct sockaddr_in6*)sa)->sin6_addr);
}


int main(int argc, char *argv[]) {
  int sockfd, numbytes;  
  char buf[MAXDATASIZE];
  struct addrinfo hints, *servinfo, *p;
  int rv;
  char s[INET6_ADDRSTRLEN];

  // validate params
  if (argc != 2) {
    fprintf(stderr,"usage: client hostname\n");
    exit(1);
  }

  // initialize hints
  memset(&hints, 0, sizeof hints);
  hints.ai_family = AF_UNSPEC;
  hints.ai_socktype = SOCK_STREAM; // stream => use tcp protocol

  // resolve hostname to ip address
  // fill servinfo obj with networking info on the server
  if ((rv = getaddrinfo(argv[1], PORT, &hints, &servinfo)) != 0) {
    fprintf(stderr, "getaddrinfo: %s\n", gai_strerror(rv));
    return 1;
  }

  // loop through all the results and connect to the first we can
  for(p = servinfo; p != NULL; p = p->ai_next) {
    // try creating a socket file descriptor with the info from servinfo
    if ((sockfd = socket(p->ai_family, p->ai_socktype,
            p->ai_protocol)) == -1) {
      perror("client: socket");
      continue;
    }

    // attempt to connect to the newly created socket
    if (connect(sockfd, p->ai_addr, p->ai_addrlen) == -1) {
      close(sockfd);
      perror("client: connect");
      continue;
    }

    break;
  }

  if (p == NULL) {
    fprintf(stderr, "client: failed to connect\n");
    return 2;
  }
  // all went well : connection is now established to the server

  // convert binary ip address to readable form
  inet_ntop(p->ai_family, get_in_addr((struct sockaddr *)p->ai_addr),
                                                  s, sizeof s);
  printf("client: connecting to %s\n", s);

  freeaddrinfo(servinfo); // all done with this structure

  // receive info from the server
  int idx = 0;
  uint32_t res = 0;
  uint32_t b = 0;
  // read 4 unsigned int from server 
  for(idx = 0; idx < 4; ++idx) {
    if ((numbytes = recv(sockfd, &b, 4, 0)) == -1) {
      perror("recv");
      exit(1);
    }

    printf("client: received '%d'\n",b);
    printf("num bytes received '%d'\n", numbytes);
    res += b;
  }
  printf("sum = %d\n", res);

  // send the sum to the server
  if ((numbytes = send(sockfd, &res, sizeof(res),0)) == -1) {
    perror("send");
    exit(1);
  }

  // read a response buffer from the server
  if ((numbytes = recv(sockfd, buf, MAXDATASIZE-1, 0)) == -1) {
    perror("recv");
    exit(1);
  }
  buf[numbytes] = '\0';
  printf("client: received '%s'\n",buf);
  printf("num bytes received '%d'\n", numbytes);
  char* sres;

  // close the connection
  close(sockfd);

  return 0;
}


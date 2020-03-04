# loop-server-p2p
A P2P add-on to the AtomJump Messaging server


This software includes a NodeJS server and a NodeJS peer client to enable 
AtomJump Messaging (http://atomjump.org) to be distributed across multiple
peers.

The NodeJS peer client is included in a VM (likely a .vmdk) that can be downloaded to any
server or PC and is installed with relative ease by a novice. The peer client VM includes a full local
PHP loop-server with MySQL database and/or NodeJS loop-server-fast for faster reads.

The NodeJS server handles incoming requests and carries out load balancing using a MySQL in-memory
RAM table, and responds to the incoming requests.

Due to the nature of the messaging problem, each peer is assigned the task of serving up only a 
certain number of messaging forums. The peer client polls the server on a regular basis (e.g. every 5 seconds) for new
tasks which relate to those particular messaging forums. If it is the 1st node able to respond, the task becomes
locked, and is removed from the server.

This is a large database sharding style effort, where 3 or 4 peers each contain the data for particular forums,
but no more. It effectively allows a multi-read / multi-write messaging database to a large scale.

The server maintains a global current message ID, so that new read / write requests will always correspond to the right
messages across servers.

For a new peer to be invited to serve a forum, an existing peer that is handling the forum must be informed,
and will serve up the existing .sql for that forum.

Each peer maintains a 'last task viewed ID', which is indexed on the server so that each read request is fast, because
it only looks at new requests.

Note: the server's MySQL database could be potentially be stored across multi-read hardware to ensure speed. Though
since it is only a small rotating cache, the RAM table should allow overall system scaling to high levels.

The server is responsible for balancing the load across each peer, and adapting this for busy forums, inviting new peers
in when necessary to forums.


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

This is a large database-style 'sharding' effort, where 3 or 4 peers each contain the data for particular forums,
but no more. It effectively allows a multi-read / multi-write messaging database to a large scale.

The server maintains a global current message ID, so that new read / write requests will always correspond to the right
messages across servers.

For a new peer to be invited to serve a forum, an existing peer that is handling the forum must be informed,
and will serve up the existing .sql for that forum.

Each peer maintains a 'last task viewed ID', which is indexed on the server so that each read request is fast, because
it only looks at new requests.

Note: the server's MySQL database could be stored across multi-read hardware using the NDB cluster approach to ensure speed /availability. Since it is only a small rotating cache, the RAM table should allow overall system scaling to high levels.
However a MEMORY table is also adequate for slightly less scalability.

The server is responsible for balancing the load across each peer, and adapting this for busy forums, inviting new peers
in when necessary to forums.

Create user requests are shared to all nodes, and the user database is complete on all nodes.

Sessions: on an update to a session record on one peer, a session update message is sent to the server in relation to that
forum, only. When a request goes for processing from that forum, the session update is also implemented on the peer, first, if there are any session updates for that forum.


# Sample read requests

These must be routed to the correct peer based on the forum name.

https://atomjump.com/api/search-secure.php?width=1322&height=302&uniqueFeedbackId=ajps_test&myMachineUser=92.27.10.17:8&cssFeedback=https%3A%2F%2Fatomjump.com%2Fcss%2Fcomments-1.0.4.css&cssBootstrap=https%3A%2F%2Fatomjump.com%2Fcss%2Fbootstrap.min.css&server=https%3A%2F%2Fatomjump.com%2Fapi&clientremoteurl=https%3A%2F%2Ftest.atomjump.com%2F

https://atomjump.com/api/logged-status.php?callback=jQuery111001906744773801886_1583350777474&passcode=ajps_test&email_modified=false&your-name-opt=&email-opt=&pd=&ph=&lang=en&users=&subscriberlimit=&setforumpassword=&forumpasscheck=&setforumtitle=test%40&_=1583350777475


https://atomjump.com/api/search-chat.php?callback=jQuery111001906744773801886_1583350777476&lat=&lon=&passcode=ajps_test&units=mi&volume=1&records=25&whisper_site=92.27.10.17%3A8&sessionId=1p9nltbl2j449h1tv7a3f4tks3&_=1583350777477


https://fast.atomjump.com/search-chat.php?callback=jQuery111001906744773801886_1583350777476&lat=&lon=&passcode=ajps_test&units=mi&volume=1&records=25&whisper_site=92.27.10.17%3A8&sessionId=1p9nltbl2j449h1tv7a3f4tks3&_=1583350777477


From these requests
uniqueFeedbackId
passcode
both hold the forum name (ajps_test in this case).
The 3rd request is to the NodeJS server (whereby the fast.atomjump.com gets rerouted to the correct port number).


# Sample write requests

These must be routed to the correct peer based on the forum name.

https://atomjump.com/api/index.php?callback=jQuery111007185678883165553_1583350964824&action=ssshout&lat=&lon=&whisper_to=&whisper_site=&your_name=&passcode=ajps_test&reading=&remoteapp=true&clientremoteurl=https%3A%2F%2Ftest.atomjump.com%2F&remoteurl=https%253A%252F%252Fatomjump.com%252Fapi%252Fsearch-secure.php%253Fwidth%253D1322%2526height%253D302%2526uniqueFeedbackId%253Dajps_test%2526myMachineUser%253D92.27.10.17%253A8%2526cssFeedback%253Dhttps%25253A%25252F%25252Fatomjump.com%25252Fcss%25252Fcomments-1.0.4.css%2526cssBootstrap%253Dhttps%25253A%25252F%25252Fatomjump.com%25252Fcss%25252Fbootstrap.min.css%2526server%253Dhttps%25253A%25252F%25252Fatomjump.com%25252Fapi%2526clientremoteurl%253Dhttps%25253A%25252F%25252Ftest.atomjump.com%25252F&units=mi&short_code=&public_to=&volume=1.00&ses=1p9nltbl2j449h1tv7a3f4tks3&cs=21633478&typing=on&shout_id=&msg_id=1&message=S&email=&phone=&shouted=S&_=1583350964826



https://atomjump.com/api/index.php?callback=jQuery111007185678883165553_1583350964822&action=ssshout&lat=&lon=&whisper_to=&whisper_site=92.27.10.17%3A8&your_name=&passcode=ajps_test&reading=&remoteapp=true&clientremoteurl=https%3A%2F%2Ftest.atomjump.com%2F&remoteurl=https%253A%252F%252Fatomjump.com%252Fapi%252Fsearch-secure.php%253Fwidth%253D1322%2526height%253D302%2526uniqueFeedbackId%253Dajps_test%2526myMachineUser%253D92.27.10.17%253A8%2526cssFeedback%253Dhttps%25253A%25252F%25252Fatomjump.com%25252Fcss%25252Fcomments-1.0.4.css%2526cssBootstrap%253Dhttps%25253A%25252F%25252Fatomjump.com%25252Fcss%25252Fbootstrap.min.css%2526server%253Dhttps%25253A%25252F%25252Fatomjump.com%25252Fapi%2526clientremoteurl%253Dhttps%25253A%25252F%25252Ftest.atomjump.com%25252F&units=mi&short_code=&public_to=&volume=1.00&ses=1p9nltbl2j449h1tv7a3f4tks3&cs=21633478&typing=off&shout_id=912394&msg_id=1&message=Starting+to+type%0D%0A&email=&phone=&shouted=&_=1583350964829


The 1st request is on starting to type, and the 2nd request is on conclusion of typing.
Distinguishing factor 'index.php'

'passcode' holds the forum name.

Now: the ses value is the session, which also has to be global.
Also shout_id=912394
is the global message id. It is not there in the 1st request because a new message is being created.


# Sample static requests

These can be handled by any peer e.g. image, js or CSS files.

https://atomjump.com/api/plugins/emoticons_large/icons/art/face1.png
https://atomjump.com/analytics/piwik/piwik.js


# Global dynamic images

On atomjump.com, we have these from a different subdomain, which potentially could be targeted to an existing
image CDN, but we may want to be able to handle this with the P2P structure too in future.

https://image-properties.atomjump.com/test_OWN.jpg
https://images.atomjump.com/upl43696-71103225.jpg
https://frontcdn.atomjump.com/atomjump-frontend/comments-1.0.4.css?ver=1



# Database structure




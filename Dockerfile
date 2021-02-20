FROM alpine/git
COPY action.sh /action.sh
ENTRYPOINT ["/action.sh"]

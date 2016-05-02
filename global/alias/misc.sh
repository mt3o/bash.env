# Miscellaneous aliases
alias c='clear'
alias cls='clear'
alias h='history'
alias path='echo $PATH'
alias reloadenv=". $HOME/.env/bash.env.sh"



# Create a git.io short URL
function gitio() {
    if [ -z "${1}" -o -z "${2}" ]; then
	echo "Usage: \`gitio slug url\`";
	return 1;
    fi;
    curl -i http://git.io/ -F "url=${2}" -F "code=${1}";
}

# Start an HTTP server from a directory, optionally specifying the port
function server-simple() {
    local port="${1:-8000}";
    sleep 1 && open "http://0.0.0.0:${port}/" &
    # Set the default Content-Type to `text/plain` instead of `application/octet-stream`
    # And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
    python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port";
}

function server-php() {
    local port="${1:-9000}";
    sleep 1 && open "http://0.0.0.0:${port}/" &
    php -S "${ip}:${port}";
}



# Syntax-highlight JSON strings or files
# Usage: `json '{"foo":42}'` or `echo '{"foo":42}' | json`
function json() {
    if [ -t 0 ]; then # argument
	python -mjson.tool <<< "$*" | pygmentize -l javascript;
    else # pipe
	python -mjson.tool | pygmentize -l javascript;
    fi;
}


function digga() {
    dig +nocmd "$1" any +multiline +noall +answer;
}


# UTF-8-encode a string of Unicode symbols
function escape() {
    printf "\\\x%s" $(printf "$@" | xxd -p -c1 -u);
    # print a newline unless we’re piping the output to another program
    if [ -t 1 ]; then
	echo ""; # newline
    fi;
}

# Decode \x{ABCD}-style Unicode escape sequences
function unidecode() {
    perl -e "binmode(STDOUT, ':utf8'); print \"$@\"";
    # print a newline unless we’re piping the output to another program
    if [ -t 1 ]; then
	echo ""; # newline
    fi;
}

# Get a character’s Unicode code point
function codepoint() {
    perl -e "use utf8; print sprintf('U+%04X', ord(\"$@\"))";
    # print a newline unless we’re piping the output to another program
    if [ -t 1 ]; then
	echo ""; # newline
    fi;

}



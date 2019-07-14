source /usr/share/defaults/etc/profile

#export PS1="\[\e[48;5;37;1;3;35m\]\u\[\e[38;5;245m\]@\[\033[1;91m\]\H \[\e[0;3;38;5;141m\]\w \[\e[1;38;5;248m\]$ \[\e[0m\]"
export PYTHONPATH=$PYTHONPATH:/usr/lib64/python3.6/site-packages

bash_prompt_command() {
    # How many characters of the $PWD should be kept
    local pwdmaxlen=15

    # Indicate that there has been dir truncation
    local trunc_symbol=".."

    # Store local dir
    local dir=${PWD##*/}

    # Which length to use
    pwdmaxlen=$(( ( pwdmaxlen < ${#dir} ) ? ${#dir} : pwdmaxlen ))

    NEW_PWD=${PWD/#$HOME/\~}
    
    local pwdoffset=$(( ${#NEW_PWD} - pwdmaxlen ))

    # Generate name
    if [ ${pwdoffset} -gt "0" ]
    then
        NEW_PWD=${NEW_PWD:$pwdoffset:$pwdmaxlen}
        NEW_PWD=${trunc_symbol}/${NEW_PWD#*/}
    fi
}

## COLORIZE BASH PROMT
bash_prompt() {

    # SETTINGS
    local BOLD="1;"
    local ITAL="3;"
    local NO_FORMAT="\[\e[0m\]"

    # COLORS
    local D_BLUE="25"
    local BLUE="32"
    local L_BLUE="74"
    local WHITE="231"

	#################################################################
	## USER SELECTION FOR COLOR HERE
	#################################################################

    # USER SELECTION
    local BG1=$D_BLUE
    local BG2=$BLUE
    local BG3=$L_BLUE
	local F1=$WHITE
	local F2=$WHITE
	local F3=$WHITE
	local EFFECT=$BOLD$ITAL

	#################################################################

    # PROMPT BEGINNING AND ENDS
    local START="\[\e["
    local END="m\]"
	local END_SEP="\]"
    local END_USER=" \u "
    local END_HOST=" \h "
    local END_PWD=" \${NEW_PWD} "
    local BG="48;5;"
    local FNT="38;5;"
    local MID=";"
    local DEFAULT_BG="0;39;"

    # GENERATE PROMT SECTIONS
	local C1="$BG$BG1$MID$FNT$F1$END"
	local C2="$BG$BG2$MID$FNT$F2$END"
	local C3="$BG$BG3$MID$FNT$F3$END"    
    local PROMPT_START="\[\e[1;3;39m\]"
    local PROMPT_USER="$START$EFFECT$C1$END_USER"
    local PROMPT_HOST="$START$EFFECT$C2$END_HOST"
    local PROMPT_PWD="$START$EFFECT$C3$END_PWD"
    local PROMT_INPUT="$NO_FORMAT "


    ############################################################################
    ## SEPARATOR FORMATING                                                    ##
    ## Generate the separators between sections                               ##
    ## Uses background colors of the sections                                 ##
    ############################################################################

    ## CONFIGURE SEPARATORS
    local SEPARATOR_FORMAT_0="$START$DEFAULT_BG$FNT$D_BLUE$END"
    local SEPARATOR_FORMAT_1="$START$BG$BLUE$MID$FNT$D_BLUE$END"
    local SEPARATOR_FORMAT_2="$START$BG$L_BLUE$MID$FNT$BLUE$END"
    local SEPARATOR_FORMAT_3="$START$DEFAULT_BG$FNT$L_BLUE$END"

    # GENERATE SEPARATORS WITH FANCY TRIANGLE
    local TRIANGLE=$'\uE0B0'
    local TRIANGLE2=$'\uE0B1'
    local SEPARATOR_0=$SEPARATOR_FORMAT_0
    local SEPARATOR_1=$SEPARATOR_FORMAT_1$TRIANGLE
    local SEPARATOR_2=$SEPARATOR_FORMAT_2$TRIANGLE
    local SEPARATOR_3=$SEPARATOR_FORMAT_3$TRIANGLE

    ############################################################################
    ## BASH PROMT                                                             ##
    ## Generate promt and remove format from the rest                         ##
    ############################################################################
    PS1="${SEPARATOR_0} ${PROMPT_START}${PROMPT_USER}${SEPARATOR_1}${PROMPT_HOST}${SEPARATOR_2}${PROMPT_PWD}${SEPARATOR_3}${PROMT_INPUT}"

    ## For terminal line coloring, leaving the rest standard
    none="$(tput sgr0)"
    trap 'echo -ne "${none}"' DEBUG
}

################################################################################
##  MAIN                                                                      ##
################################################################################

PROMPT_COMMAND=bash_prompt_command

bash_prompt
unset bash_prompt

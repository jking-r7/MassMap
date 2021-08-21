#!/bin/bash

VERSION="2.0"

TARGET="$1"

WORKING_DIR="$(cd "$(dirname "$0")" ; pwd -P)"
RESULTS_PATH="$WORKING_DIR/results"

RED="\033[1;31m"
GREEN="\033[1;32m"
BLUE="\033[1;36m"
YELLOW="\033[1;33m"
RESET="\033[0m"


displayLogo(){
echo -e "${GREEN}                               
 _______                     _______              
|   |   |.---.-.-----.-----.|   |   |.---.-.-----.
|       ||  _  |__ --|__ --||       ||  _  |  _  |
|__|_|__||___._|_____|_____||__|_|__||___._|   __|${RESET} ${RED}v$VERSION${RESET}  
                                           ${GREEN}|__|${RESET}    by ${YELLOW}@CaptMeelo${RESET}\n
"
}


checkArgs(){
    if [[ $# -eq 0 ]]; then
        echo -e "\t${RED}[!] ERROR:${RESET} Invalid argument!\n"
        echo -e "\t${GREEN}[+] USAGE:${RESET}$0 <file-containing-list-of-IP/CIDR>\n"
        exit 1
    elif [ ! -s $1 ]; then
        echo -e "\t${RED}[!] ERROR:${RESET} File is empty and/or does not exists!\n"
        echo -e "\t${GREEN}[+] USAGE:${RESET}$0 <file-containing-list-of-IP/CIDR>\n"
        exit 1
    fi
}

portScan(){
    echo -e "${GREEN}[+] Checking if results directory already exists.${RESET}"
    if [ -d $RESULTS_PATH ]
    then
        echo -e "${BLUE}[-] Directory already exists. Skipping...${RESET}"
    else
        echo -e "${GREEN}[+] Creating results directory.${RESET}"
        mkdir -p $RESULTS_PATH
    fi

    echo -e "${GREEN}[+] Running Masscan.${RESET}"
    sudo masscan -p 1,3-4,6-7,9,13,17,19-26,30,32-33,37,42-43,49,53,70,79-85,88-90,99-100,106,109-111,113,119,125,135,139,143-144,146,161,163,179,199,211-212,222,254-256,259,264,280,301,306,311,340,366,389,406-407,416-417,425,427,443-445,458,464-465,481,497,500,512-515,524,541,543-545,548,554-555,563,587,593,616-617,625,631,636,646,648,666-668,683,687,691,700,705,711,714,720,722,726,749,765,777,783,787,800-801,808,843,873,880,888,898,900-903,911-912,981,987,990,992-993,995,999-1002,1007,1009-1011,1021-1100,1102,1104-1108,1110-1114,1117,1119,1121-1124,1126,1130-1132,1137-1138,1141,1145,1147-1149,1151-1152,1154,1163-1166,1169,1174-1175,1183,1185-1187,1192,1198-1199,1201,1213,1216-1218,1233-1234,1236,1244,1247-1248,1259,1271-1272,1277,1287,1296,1300-1301,1309-1311,1322,1328,1334,1352,1417,1433-1434,1443,1455,1461,1494,1500-1501,1503,1521,1524,1533,1556,1580,1583,1594,1600,1641,1658,1666,1687-1688,1700,1717-1721,1723,1755,1761,1782-1783,1801,1805,1812,1839-1840,1862-1864,1875,1900,1914,1935,1947,1971-1972,1974,1984,1998-2010,2013,2020-2022,2030,2033-2035,2038,2040-2043,2045-2049,2065,2068,2099-2100,2103,2105-2107,2111,2119,2121,2126,2135,2144,2160-2161,2170,2179,2190-2191,2196,2200,2222,2251,2260,2288,2301,2323,2366,2381-2383,2393-2394,2399,2401,2492,2500,2522,2525,2557,2601-2602,2604-2605,2607-2608,2638,2701-2702,2710,2717-2718,2725,2800,2809,2811,2869,2875,2909-2910,2920,2967-2968,2998,3000-3001,3003,3005-3007,3011,3013,3017,3030-3031,3050,3052,3071,3077,3119,3128,3162,3168,3211,3221,3260-3261,3268-3269,3283,3300-3301,3304,3306-3307,3322-3325,3333,3351,3367,3369-3372,3376,3389-3390,3400,3404,3410,3476,3493,3514,3517,3527,3546,3551,3580,3659,3684,3689-3690,3697,3700,3703,3731,3737,3766,3784,3792,3800-3801,3808-3809,3814,3820,3824,3826-3828,3846,3848-3849,3851-3853,3859,3863,3869-3872,3878,3880,3888-3889,3905,3907,3914,3916,3918,3920,3929,3931,3941,3944-3945,3957,3963,3968-3969,3971-3972,3981,3986,3990,3993-3995,3998,4000-4006,4009,4040,4045,4080,4096,4111,4125-4126,4129,4143,4147,4164,4200,4224,4242,4252,4279,4321,4343,4430,4443-4446,4449,4550,4555,4567,4600,4658,4662,4848,4875,4899-4900,4949,4998,5000-5004,5009,5030,5033,5040,5050-5051,5054,5060-5061,5063,5074,5080-5081,5087,5100-5102,5120,5151,5190,5200,5212,5214,5221-5223,5225-5226,5242,5269,5279-5280,5298,5339,5353,5357,5405,5414,5431-5432,5440,5500-5501,5510,5544,5550,5555,5560,5566,5631,5633,5666,5678-5679,5718,5730,5800-5802,5807,5810-5812,5815,5818,5822-5823,5825,5850,5859,5862,5868-5869,5877,5899-5907,5909-5911,5914-5915,5918,5922,5925,5938,5940,5950,5952,5959-5963,5968,5981,5987-5989,5998-6007,6009,6025,6051,6059-6060,6068,6100-6101,6106,6112,6123,6129,6156,6203,6247,6346,6389,6481,6500,6502,6504,6510,6520,6543,6547,6550,6565-6567,6580,6600,6646,6666-6669,6689,6692,6699,6711,6732,6779,6788-6789,6792,6839,6881,6896,6901,6969,7000-7002,7004,7007,7019,7024-7025,7050-7051,7070,7080,7100,7103,7106,7123,7200-7201,7241,7272,7278,7281,7402,7435,7438,7443,7496,7512,7625,7627,7676,7725,7741,7744,7749,7770,7777-7778,7800,7878,7900,7911,7913,7920-7921,7929,7937-7938,7999-8002,8007-8011,8015-8016,8019,8021-8022,8031,8042,8045,8050,8080-8090,8093,8095,8097-8100,8180-8181,8189,8192-8194,8200,8222,8254,8290-8294,8300,8333,8383,8385,8400,8402,8443,8481,8500,8540,8600,8648-8649,8651-8652,8654,8675-8676,8686,8701,8765-8766,8800,8873,8877,8888-8889,8899,8987,8994,8996,9000-9003,9009-9011,9040,9050,9071,9080-9081,9090-9091,9098-9103,9110-9111,9191,9197-9198,9200,9207,9220,9290,9409,9415,9418,9443-9444,9485,9500-9503,9535,9575,9593-9595,9600,9618,9621,9643,9666,9673,9815,9876-9878,9898,9900,9914,9917,9929,9941,9943-9944,9968,9988,9998-10004,10008-10012,10022-10025,10034,10058,10082,10160,10180,10215,10243,10566,10616-10617,10621,10626,10628-10629,10778,10873,11110-11111,11967,12000,12006,12021,12059,12174,12215,12262,12265,12345,12380,12452,13456,13722,13724,13782-13783,14000,14238,14441-14442,15000-15004,15402,15660,15742,16000-16001,16012,16016,16018,16080,16113,16705,16800,16851,16992-16993,17595,17877,17988,18018,18040,18101,18264,18988,19101,19283,19315,19350,19780,19801,19842,19900,20000,20002,20005,20031,20221-20222,20828,21571,21792,22222,22939,23052,23502,23796,24444,24800,25734-25735,26000,26214,26470,27000,27352-27353,27355-27357,27715,28201,28211,29672,29831,30000,30005,30704,30718,30951,31038,31337,31727,32768-32785,32791-32792,32803,32816,32822,32835,33354,33899,34571-34573,35500,38292,40193,40911,41511,42510,44176,44442-44443,44501,45100,48080,49152-49161,49163,49165,49167,49175-49176,49400,49999-50003,50006,50300,50389,50500,50636,50800,51103,51493,52673,52822,52848,52869,54045,54328,55055-55056,55555,55600,56737-56738,57294,57797,58080,60020,60443,61532,61900,62078,63331,64623,64680,65000,65129,65389 --rate 6000 --wait 0 --open -iL $TARGET -oX $RESULTS_PATH/masscan.xml
    if [ -f "$WORKING_DIR/paused.conf" ] ; then
        sudo rm "$WORKING_DIR/paused.conf"
    fi
    open_ports=$(cat $RESULTS_PATH/masscan.xml | grep portid | cut -d "\"" -f 10 | sort -n | uniq | paste -sd,)
    cat $RESULTS_PATH/masscan.xml | grep portid | cut -d "\"" -f 4 | sort -V | uniq > $WORKING_DIR/nmap_targets.tmp
    echo -e "${RED}[*] Masscan Done!"

    echo -e "${GREEN}[+] Running Nmap.${RESET}"
    sudo nmap -sVC -O -p $open_ports --open -v -Pn -n -T4 -iL $WORKING_DIR/nmap_targets.tmp -oA $RESULTS_PATH/nmap
    sudo rm $WORKING_DIR/nmap_targets.tmp
    xsltproc -o $RESULTS_PATH/nmap-native.html $RESULTS_PATH/nmap.xml
    xsltproc -o $RESULTS_PATH/nmap-bootstrap.html $WORKING_DIR/bootstrap-nmap.xsl $RESULTS_PATH/nmap.xml
    echo -e "${RED}[*] Nmap Done! View the HTML reports at $RESULTS_PATH${RESET}"
}


displayLogo
checkArgs $TARGET
portScan

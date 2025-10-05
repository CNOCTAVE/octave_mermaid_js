## Copyright (C) 2024-2025 Yu Hongbo <yuhongbo@member.fsf.org>,
##                    CNOCTAVE <cnoctave@qq.com>
##
## This program is free software; you can redistribute it and/or modify it under
## the terms of the GNU General Public License as published by the Free Software
## Foundation; either version 3 of the License, or (at your option) any later
## version.
##
## This program is distributed in the hope that it will be useful, but WITHOUT
## ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
## FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
## details.
##
## You should have received a copy of the GNU General Public License along with
## this program; if not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*-
## @deftypefn {} {mermaid_js_example_string =} mermaid_js_examples (@var{name})  
## Get octave_mermaid_js examples.  
## Support examples:  
## name | description  
## -----------------------------------------------------------------------------  
## flowchart | flowchart  
## sequence_diagram | sequence diagram  
## class_diagram | class diagram  
## state_diagram | state diagram  
## er_diagram | ER diagram  
## user_journey_diagram | user journey diagram  
## gantt_chart | Gantt Chart  
## pie_chart | pie chart  
## quadrant_chart | quadrant chart  
## requirement_diagram | requirement diagram  
## git_graph | Git Graph  
## c4_diagram | C4 Diagram  
## mindmap | Mindmap  
## timeline | timeline  
## zenuml | ZenUML  
## sankey_diagram | Sankey diagram  
## xy_chart | XY Chart  
## block_diagram | Block Diagram  
## packet_diagram | packet diagram  
## mermaid_s_kanban_diagram | Mermaid’s Kanban diagram  
## architecture_diagram | architecture diagram  
## radar_diagram | radar diagram  
## treemap_diagram | treemap diagram  
## @example
## param: name
##
## return: mermaid_js_example_string
## @end example
##
## @end deftypefn
function mermaid_js_example_string = mermaid_js_examples(name)
    if nargin < 1
        print_usage();
    endif
    if (ischar(name) != 1)
        error('name must be a string.');
    endif
    if strcmp(name, "flowchart") == 1
        text_cell = {
            "flowchart LR",
            "    Start --> Stop",
        };
    elseif strcmp(name, "sequence_diagram") == 1
        text_cell = {
            "sequenceDiagram",
            "    Alice->>John: Hello John, how are you?",
            "    John-->>Alice: Great!",
            "    Alice-)John: See you later!",
        };
    elseif strcmp(name, "class_diagram") == 1
        text_cell = {
            "---",
            "title: Animal example",
            "---",
            "classDiagram",
            "    note \"From Duck till Zebra\"",
            "    Animal <|-- Duck",
            "    note for Duck \"can fly\\ncan swim\\ncan dive\\ncan help in debugging\"",
            "    Animal <|-- Fish",
            "    Animal <|-- Zebra",
            "    Animal : +int age",
            "    Animal : +String gender",
            "    Animal: +isMammal()",
            "    Animal: +mate()",
            "    class Duck{",
            "        +String beakColor",
            "        +swim()",
            "        +quack()",
            "    }",
            "    class Fish{",
            "        -int sizeInFeet",
            "        -canEat()",
            "    }",
            "    class Zebra{",
            "        +bool is_wild",
            "        +run()",
            "    }",
        };
    elseif strcmp(name, "state_diagram") == 1
        text_cell = {
            "---",
            "title: Simple sample",
            "---",
            "stateDiagram-v2",
            "    [*] --> Still",
            "    Still --> [*]",
            "    Still --> Moving",
            "    Moving --> Still",
            "    Moving --> Crash",
            "    Crash --> [*]",
        };
    elseif strcmp(name, "er_diagram") == 1
        text_cell = {
            "---",
            "title: Order example",
            "---",
            "erDiagram",
            "    CUSTOMER ||--o{ ORDER : places",
            "    ORDER ||--|{ LINE-ITEM : contains",
            "    CUSTOMER }|..|{ DELIVERY-ADDRESS : uses",
        };
    elseif strcmp(name, "user_journey_diagram") == 1
        text_cell = {
            "journey",
            "    title My working day",
            "    section Go to work",
            "      Make tea: 5: Me",
            "      Go upstairs: 3: Me",
            "      Do work: 1: Me, Cat",
            "    section Go home",
            "      Go downstairs: 5: Me",
            "      Sit down: 5: Me",
        };
    elseif strcmp(name, "gantt_chart") == 1
        text_cell = {
            "gantt",
            "    title A Gantt Diagram",
            "    dateFormat YYYY-MM-DD",
            "    section Section",
            "        A task          :a1, 2014-01-01, 30d",
            "        Another task    :after a1, 20d",
            "    section Another",
            "        Task in Another :2014-01-12, 12d",
            "        another task    :24d",
        };
    elseif strcmp(name, "pie_chart") == 1
        text_cell = {
            "pie title Pets adopted by volunteers",
            "    \"Dogs\" : 386",
            "    \"Cats\" : 85",
            "    \"Rats\" : 15",
        };
    elseif strcmp(name, "quadrant_chart") == 1
        text_cell = {
            "quadrantChart",
            "    title Reach and engagement of campaigns",
            "    x-axis Low Reach --> High Reach",
            "    y-axis Low Engagement --> High Engagement",
            "    quadrant-1 We should expand",
            "    quadrant-2 Need to promote",
            "    quadrant-3 Re-evaluate",
            "    quadrant-4 May be improved",
            "    Campaign A: [0.3, 0.6]",
            "    Campaign B: [0.45, 0.23]",
            "    Campaign C: [0.57, 0.69]",
            "    Campaign D: [0.78, 0.34]",
            "    Campaign E: [0.40, 0.34]",
            "    Campaign F: [0.35, 0.78]",
        };
    elseif strcmp(name, "requirement_diagram") == 1
        text_cell = {
            "    requirementDiagram",
            "",
            "    requirement test_req {",
            "    id: 1",
            "    text: the test text.",
            "    risk: high",
            "    verifymethod: test",
            "    }",
            "",
            "    element test_entity {",
            "    type: simulation",
            "    }",
            "",
            "    test_entity - satisfies -> test_req",
        };
    elseif strcmp(name, "git_graph") == 1
        text_cell = {
            "---",
            "title: Example Git diagram",
            "---",
            "gitGraph",
            "   commit",
            "   commit",
            "   branch develop",
            "   checkout develop",
            "   commit",
            "   commit",
            "   checkout main",
            "   merge develop",
            "   commit",
            "   commit",
        };
    elseif strcmp(name, "c4_diagram") == 1
        text_cell = {
            "    C4Context",
            "      title System Context diagram for Internet Banking System",
            "      Enterprise_Boundary(b0, \"BankBoundary0\") {",
            "        Person(customerA, \"Banking Customer A\", \"A customer of the bank, with personal bank accounts.\")",
            "        Person(customerB, \"Banking Customer B\")",
            "        Person_Ext(customerC, \"Banking Customer C\", \"desc\")",
            "",
            "        Person(customerD, \"Banking Customer D\", \"A customer of the bank, <br/> with personal bank accounts.\")",
            "",
            "        System(SystemAA, \"Internet Banking System\", \"Allows customers to view information about their bank accounts, and make payments.\")",
            "",
            "        Enterprise_Boundary(b1, \"BankBoundary\") {",
            "",
            "          SystemDb_Ext(SystemE, \"Mainframe Banking System\", \"Stores all of the core banking information about customers, accounts, transactions, etc.\")",
            "",
            "          System_Boundary(b2, \"BankBoundary2\") {",
            "            System(SystemA, \"Banking System A\")",
            "            System(SystemB, \"Banking System B\", \"A system of the bank, with personal bank accounts. next line.\")",
            "          }",
            "",
            "          System_Ext(SystemC, \"E-mail system\", \"The internal Microsoft Exchange e-mail system.\")",
            "          SystemDb(SystemD, \"Banking System D Database\", \"A system of the bank, with personal bank accounts.\")",
            "",
            "          Boundary(b3, \"BankBoundary3\", \"boundary\") {",
            "            SystemQueue(SystemF, \"Banking System F Queue\", \"A system of the bank.\")",
            "            SystemQueue_Ext(SystemG, \"Banking System G Queue\", \"A system of the bank, with personal bank accounts.\")",
            "          }",
            "        }",
            "      }",
            "",
            "      BiRel(customerA, SystemAA, \"Uses\")",
            "      BiRel(SystemAA, SystemE, \"Uses\")",
            "      Rel(SystemAA, SystemC, \"Sends e-mails\", \"SMTP\")",
            "      Rel(SystemC, customerA, \"Sends e-mails to\")",
            "",
            "      UpdateElementStyle(customerA, $fontColor=\"red\", $bgColor=\"grey\", $borderColor=\"red\")",
            "      UpdateRelStyle(customerA, SystemAA, $textColor=\"blue\", $lineColor=\"blue\", $offsetX=\"5\")",
            "      UpdateRelStyle(SystemAA, SystemE, $textColor=\"blue\", $lineColor=\"blue\", $offsetY=\"-10\")",
            "      UpdateRelStyle(SystemAA, SystemC, $textColor=\"blue\", $lineColor=\"blue\", $offsetY=\"-40\", $offsetX=\"-50\")",
            "      UpdateRelStyle(SystemC, customerA, $textColor=\"red\", $lineColor=\"red\", $offsetX=\"-50\", $offsetY=\"20\")",
            "",
            "      UpdateLayoutConfig($c4ShapeInRow=\"3\", $c4BoundaryInRow=\"1\")",
        };
    elseif strcmp(name, "mindmap") == 1
        text_cell = {
            "mindmap",
            "  root((mindmap))",
            "    Origins",
            "      Long history",
            "      ::icon(fa fa-book)",
            "      Popularisation",
            "        British popular psychology author Tony Buzan",
            "    Research",
            "      On effectiveness<br/>and features",
            "      On Automatic creation",
            "        Uses",
            "            Creative techniques",
            "            Strategic planning",
            "            Argument mapping",
            "    Tools",
            "      Pen and paper",
            "      Mermaid",
        };
    elseif strcmp(name, "timeline") == 1
        text_cell = {
            "timeline",
            "    title History of Social Media Platform",
            "    2002 : LinkedIn",
            "    2004 : Facebook",
            "         : Google",
            "    2005 : YouTube",
            "    2006 : Twitter",
        };
    elseif strcmp(name, "zenuml") == 1
        text_cell = {
            "zenuml",
            "    title Demo",
            "    Alice->John: Hello John, how are you?",
            "    John->Alice: Great!",
            "    Alice->John: See you later!",
        };
    elseif strcmp(name, "sankey_diagram") == 1
        text_cell = {
            "---",
            "config:",
            "  sankey:",
            "    showValues: false",
            "---",
            "sankey",
            "",
            "Agricultural 'waste',Bio-conversion,124.729",
            "Bio-conversion,Liquid,0.597",
            "Bio-conversion,Losses,26.862",
            "Bio-conversion,Solid,280.322",
            "Bio-conversion,Gas,81.144",
            "Biofuel imports,Liquid,35",
            "Biomass imports,Solid,35",
            "Coal imports,Coal,11.606",
            "Coal reserves,Coal,63.965",
            "Coal,Solid,75.571",
            "District heating,Industry,10.639",
            "District heating,Heating and cooling - commercial,22.505",
            "District heating,Heating and cooling - homes,46.184",
            "Electricity grid,Over generation / exports,104.453",
            "Electricity grid,Heating and cooling - homes,113.726",
            "Electricity grid,H2 conversion,27.14",
            "Electricity grid,Industry,342.165",
            "Electricity grid,Road transport,37.797",
            "Electricity grid,Agriculture,4.412",
            "Electricity grid,Heating and cooling - commercial,40.858",
            "Electricity grid,Losses,56.691",
            "Electricity grid,Rail transport,7.863",
            "Electricity grid,Lighting & appliances - commercial,90.008",
            "Electricity grid,Lighting & appliances - homes,93.494",
            "Gas imports,Ngas,40.719",
            "Gas reserves,Ngas,82.233",
            "Gas,Heating and cooling - commercial,0.129",
            "Gas,Losses,1.401",
            "Gas,Thermal generation,151.891",
            "Gas,Agriculture,2.096",
            "Gas,Industry,48.58",
            "Geothermal,Electricity grid,7.013",
            "H2 conversion,H2,20.897",
            "H2 conversion,Losses,6.242",
            "H2,Road transport,20.897",
            "Hydro,Electricity grid,6.995",
            "Liquid,Industry,121.066",
            "Liquid,International shipping,128.69",
            "Liquid,Road transport,135.835",
            "Liquid,Domestic aviation,14.458",
            "Liquid,International aviation,206.267",
            "Liquid,Agriculture,3.64",
            "Liquid,National navigation,33.218",
            "Liquid,Rail transport,4.413",
            "Marine algae,Bio-conversion,4.375",
            "Ngas,Gas,122.952",
            "Nuclear,Thermal generation,839.978",
            "Oil imports,Oil,504.287",
            "Oil reserves,Oil,107.703",
            "Oil,Liquid,611.99",
            "Other waste,Solid,56.587",
            "Other waste,Bio-conversion,77.81",
            "Pumped heat,Heating and cooling - homes,193.026",
            "Pumped heat,Heating and cooling - commercial,70.672",
            "Solar PV,Electricity grid,59.901",
            "Solar Thermal,Heating and cooling - homes,19.263",
            "Solar,Solar Thermal,19.263",
            "Solar,Solar PV,59.901",
            "Solid,Agriculture,0.882",
            "Solid,Thermal generation,400.12",
            "Solid,Industry,46.477",
            "Thermal generation,Electricity grid,525.531",
            "Thermal generation,Losses,787.129",
            "Thermal generation,District heating,79.329",
            "Tidal,Electricity grid,9.452",
            "UK land based bioenergy,Bio-conversion,182.01",
            "Wave,Electricity grid,19.013",
            "Wind,Electricity grid,289.366",
        };
    elseif strcmp(name, "xy_chart") == 1
        text_cell = {
            "xychart",
            "    title \"Sales Revenue\"",
            "    x-axis [jan, feb, mar, apr, may, jun, jul, aug, sep, oct, nov, dec]",
            "    y-axis \"Revenue (in $)\" 4000 --> 11000",
            "    bar [5000, 6000, 7500, 8200, 9500, 10500, 11000, 10200, 9200, 8500, 7000, 6000]",
            "    line [5000, 6000, 7500, 8200, 9500, 10500, 11000, 10200, 9200, 8500, 7000, 6000]",
        };
    elseif strcmp(name, "block_diagram") == 1
        text_cell = {
            "block",
            "columns 1",
            "  db((\"DB\"))",
            "  blockArrowId6<[\"&nbsp;&nbsp;&nbsp;\"]>(down)",
            "  block:ID",
            "    A",
            "    B[\"A wide one in the middle\"]",
            "    C",
            "  end",
            "  space",
            "  D",
            "  ID --> D",
            "  C --> D",
            "  style B fill:#969,stroke:#333,stroke-width:4px",
        };
    elseif strcmp(name, "packet_diagram") == 1
        text_cell = {
            "packet",
            "title UDP Packet",
            "+16: \"Source Port\"",
            "+16: \"Destination Port\"",
            "32-47: \"Length\"",
            "48-63: \"Checksum\"",
            "64-95: \"Data (variable length)\"",
        };
    elseif strcmp(name, "mermaid_s_kanban_diagram") == 1
        text_cell = {
            "kanban",
            "todo[Todo]",
            "  id3[Update Database Function]@{ ticket: MC-2037, assigned: 'knsv', priority: 'High' }",
        };
    elseif strcmp(name, "architecture_diagram") == 1
        text_cell = {
            "architecture-beta",
            "    group api(cloud)[API]",
            "",
            "    service db(database)[Database] in api",
            "    service disk1(disk)[Storage] in api",
            "    service disk2(disk)[Storage] in api",
            "    service server(server)[Server] in api",
            "",
            "    db:L -- R:server",
            "    disk1:T -- B:server",
            "    disk2:T -- B:db",
        };
    elseif strcmp(name, "radar_diagram") == 1
        text_cell = {
            "---",
            "title: \"Grades\"",
            "---",
            "radar-beta",
            "  axis m[\"Math\"], s[\"Science\"], e[\"English\"]",
            "  axis h[\"History\"], g[\"Geography\"], a[\"Art\"]",
            "  curve a[\"Alice\"]{85, 90, 80, 70, 75, 90}",
            "  curve b[\"Bob\"]{70, 75, 85, 80, 90, 85}",
            "",
            "  max 100",
            "  min 0",
        };
    elseif strcmp(name, "treemap_diagram") == 1
        text_cell = {
            "treemap-beta",
            "\"Category A\"",
            "    \"Item A1\": 10",
            "    \"Item A2\": 20",
            "\"Category B\"",
            "    \"Item B1\": 15",
            "    \"Item B2\": 25",
        };
    else
        error('name must be one of the supported examples.');
    endif
    mermaid_js_example_string = strjoin(text_cell, "\n");
endfunction
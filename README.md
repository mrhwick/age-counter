# AgeCounter

Counts the number of users with a given age from an agefile csv that contains lines in the format:

```
584383,23
455195,35
575075,50
488134,22
872999,40
237582,12
178450,7
```

## Usage

### Basic Usage

The age counter executable is included in this repo, but requires the erlang runtime in order to function. You can install erlang alone, or use [the helpful instructions from the elixir website](http://elixir-lang.org/install.html) to install elixir on your machine, which will typically bring erlang along with it.

To run the command line tool on an agefile, simply run:

```bash
$ ./age_counter --file=<your agefile here>
Processing agefile.csv...
[(1,1699),(2,1656),(3,1635),(4,1608),(5,1658),(6,1672),(7,1702),(8,1628),(9,1621),(10,1643),(11,1638),(12,1689),(13,1639),(14,1747),(15,1649),(16,1637),(17,1733),(18,1652),(19,1662),(20,1644),(21,1694),(22,1729),(23,1706),(24,1648),(25,1691),(26,1652),(27,1667),(28,1664),(29,1723),(30,1614),(31,1652),(32,1694),(33,1634),(34,1642),(35,1648),(36,1666),(37,1671),(38,1622),(39,1705),(40,1724),(41,1647),(42,1696),(43,1647),(44,1749),(45,1669),(46,1695),(47,1716),(48,1639),(49,1618),(50,1675),(51,1580),(52,1637),(53,1717),(54,1689),(55,1647),(56,1714),(57,1638),(58,1632),(59,1711),(60,1626),]
```

The number of users for each age will be counted and the program will output the ages with their groups as tuples within a list.

I've included a python script which can generate agefiles, and you can run that using python 2 or 3:

```bash
$ python age_file_generator.py
Writing user ids and ages to csv file named 'agefile.csv'...
Finished writing 'agefile.csv'
```

### Failure Modes

Notably, this executable does not account for bad agefiles, since this was not specified. The python generator script will create agefiles that are within specification and can be used with the executable program. Any values in the agefile that do not match the specifications will cause a failure of the executable, and processing will cease, with some helpful output from the erlang runtime.

## Development

If you intend to develop the age counter, you'll be using escript to generate executables. This is very easy in Elixir, because mix includes bindings to all of the escript tools for building.

Whenever you want to build a new copy of the executable, you can simple run this command:

```bash
$ mix escript.build
```

/* Fernando Domínguez García */
/* Proyecto de base de datos de Hearthstone en MySQL */
/* Crea la base de datos */
drop database if exists hearthstone;
create database hearthstone;
use hearthstone;

/* Borrado de tablas si existieran */
drop table if exists have;
drop table if exists play;
drop table if exists mechanic;
drop table if exists deck;
drop table if exists card;
drop table if exists heroepower;
drop table if exists heroe;
drop table if exists expansion;


/* Creación de tablas */

create table expansion(
	codExpansion int auto_increment,
	nameExpansion varchar (70) not null,
	primary key (codExpansion)
)ENGINE=InnoDB;


create table heroe(
	codHeroe varchar (20),
	nameHeroe varchar (60) not null,
	primary key (codHeroe, nameHeroe)
)ENGINE=InnoDB;


create table heroepower(
	codHeroePw varchar (20),
	heroepower_codHeroe varchar (20),
	descriptionHeroePower varchar (60) not null,
	primary key (codHeroePw, heroepower_codHeroe),

	constraint fk_power_heroe
		foreign key (heroepower_codHeroe)
		references heroe (codHeroe)
	on delete cascade on update cascade
)ENGINE=InnoDB;

create table card(
	codCard int auto_increment not null,
	nameCard varchar (50) not null,
	rarity varchar (20) not null,
	type varchar (30) not null,
	cost smallint(50) not null,
	damage smallint(50) not null,
	health smallint(50) not null,
	descriptionCard varchar (150) default NULL,
	card_codExpansion int not null,
	primary key (codCard),

	constraint fk_card_expansion
		foreign key (card_codExpansion)
		references expansion (codExpansion)
	on delete cascade on update cascade
)ENGINE=InnoDB;


create table mechanic(
	codMechanic varchar (30),
	descriptionMechanic varchar (70),
	primary key (codMechanic)
)ENGINE=InnoDB;


create table play(
	play_codHeroe varchar (20),
	play_codCard int,
	primary key (play_codHeroe, play_codCard),

	constraint fk_play_heroe
		foreign key (play_codHeroe)
		references heroe (codHeroe)
	on delete cascade on update cascade,

	constraint fk_play_card
		foreign key (play_codCard)
		references card (codCard)
	on delete cascade on update cascade
)ENGINE=InnoDB;


create table have(
	have_codCard int,
	have_codMechanic varchar (30),
	primary key (have_codCard, have_codMechanic),

	constraint fk_have_card
		foreign key (have_codCard)
		references card (codCard)
	on delete cascade on update cascade,

	constraint fk_have_mechanic
		foreign key (have_codMechanic)
		references mechanic (codMechanic)
	on delete cascade on update cascade
)ENGINE=InnoDB;


/* Creado de la tabla "deck" para el procedimiento */
create table deck(
	deck_codCard int not null,
	nameCard varchar(50) not null,
    Heroe varchar(20) not null,
    Rarity varchar(20) not null,
    
	constraint fk_deck_card
		foreign key (deck_codCard)
		references card (codCard)
	on delete cascade on update cascade
    )ENGINE=InnoDB;


/* Introducción de los datos a la base de datos */

/* Expansion */
Insert into Expansion values (1,"Classic");
Insert into Expansion values (2,"Journey to Ungoro");
Insert into Expansion values (3,"Knights of the Frozen Throne");
Insert into Expansion values (4,"Kobolds and Catacombs");
Insert into Expansion values (5,"The Witchwood");

/* Heroe */
Insert into Heroe values ("Druid","Malfurion Stormrage");
Insert into Heroe values ("Everyone","All heroes");
Insert into Heroe values ("Hunter","Rexxar");
Insert into Heroe values ("Mage","Jaina Proudmoore");
Insert into Heroe values ("Paladin","Uther Lightbringer");
Insert into Heroe values ("Priest","Anduin Wrynn");
Insert into Heroe values ("Rogue","Valeera Sanguinar");
Insert into Heroe values ("Shaman","Thrall");
Insert into Heroe values ("Warlock","Gul'dan");
Insert into Heroe values ("Warrior","Garrosh Hellscream");

/* HeroePower */

Insert into HeroePower values ("Armor Up!","Warrior","Gain 2 Armor");
Insert into HeroePower values ("Dagger Mastery","Rogue","Equip a 1/2 Dagger");
Insert into HeroePower values ("Fireblast","Mage","Deal 1 damage");
Insert into HeroePower values ("Lesser Heal","Priest","Restore 2 Health");
Insert into HeroePower values ("Life Tap","Warlock","Draw card and take 2 damage");
Insert into HeroePower values ("Reinforce","Paladin","Summon a 1/1 Silver Hand Recruit");
Insert into HeroePower values ("Shapestshift","Druid","+1 Attack this turn. +1 Armor.");
Insert into HeroePower values ("Steady Shot","Hunter","Deal 2 damage to the enemy hero");
Insert into HeroePower values ("Totemic Call","Shaman","Summon a random Totem");
Insert into HeroePower values ("Whatever","Everyone"," It'is depends");

/* Card */
Insert into Card values (1,"Bloodreaver Gul'dan","Legendary","Playable Hero",10,0,30,"Battlecry: Summon all friendly Demons that died this game.",3);
Insert into Card values (2,"Frost Lich Jaina","Legendary","Playable Hero",9,0,30,"Battlecry: Summon a 3/6 Water Elemental. Your Elementals have Lifesteal this game.",3);
Insert into Card values (3,"Uther of the Ebon Blade","Legendary","Playable Hero",9,0,30,"Battlecry: Equip a 5/3 Lifesteal weapon.",3);
Insert into Card values (4,"Valeera the Hollow","Legendary","Playable Hero",9,0,30,"Battlecry: Gain Stealth until your next turn.",3);
Insert into Card values (5,"Hagatha the Witch","Legendary","Playable Hero",8,0,30,"Battlecry: Deal 3 damage to all minions.",5);
Insert into Card values (6,"Scourgelord Garrosh","Legendary","Playable Hero",8,0,30,"Battlecry: Equip a 4/3 Shadowmourne that also damages adjacent minions.",3);
Insert into Card values (7,"Shadowreaper Anduin","Legendary","Playable Hero",8,0,30,"Battlecry: Destroy all minions with 5 or more Attack.",3);
Insert into Card values (8,"Malfurion the Pestilent","Legendary","Playable Hero",7,0,30,"Choose One - Summon 2 Poisonous Spiders or 2 Scarabs with Taunt.",3);
Insert into Card values (9,"Deathstalker Rexxar","Legendary","Playable Hero",6,0,30,"Battlecry: Deal 2 damage to all enemy minions.",3);
Insert into Card values (10,"Thrall Deathseer","Legendary","Playable Hero",5,0,30,"Battlecry: Transform your minions into random ones that cost (2) more.",3);
Insert into Card values (11,"The Runespear","Legendary","Weapon",8,3,3,"After your hero attacks Discover a spell and cast it with random targets.",4);
Insert into Card values (12,"Woecleaver","Legendary","Weapon",8,3,3,"After your hero attacks Recruit a minion.",4);
Insert into Card values (13,"Rhok'delar","Legendary","Weapon",7,4,2,"Battlecry: If your deck has no minions fill your hand with Hunter spells.",4);
Insert into Card values (14,"Aluneth","Legendary","Weapon",6,0,3,"At the end of your turn draw 3 cards.",4);
Insert into Card values (15,"Val'anyr","Legendary","Weapon",6,4,2,"Deathrattle: Give a minion in your hand +4/+2. When it dies reequip this.",4);
Insert into Card values (16,"Skull of the Man'ari","Legendary","Weapon",5,0,3,"At the start of your turn summon a Demon from your hand.",4);
Insert into Card values (17,"Twig of the World Tree","Legendary","Weapon",4,1,5,"Deathrattle: Gain 10 Mana Crystals.",4);
Insert into Card values (18,"Dragon Soul","Legendary","Weapon",3,0,3,"After you cast 3 spells in a turn summon a 5/5 Dragon.",4);
Insert into Card values (19,"Kingsbane","Legendary","Weapon",1,1,3,"Deathrattle: Shuffle this into your deck. It keeps any enchantments.",4);
Insert into Card values (20,"Awaken the Makers","Legendary","Ability",1,0,0,"Quest: Summon 7 Deathrattle minions. Reward: Amara Warden of Hope.",2);
Insert into Card values (21,"Fire Plume's Heart","Legendary","Ability",1,0,0,"Quest: Play 7 Taunt minions. Reward: Sulfuras.",2);
Insert into Card values (22,"Jungle Giants","Legendary","Ability",1,0,0,"Quest: Summon 5 minions with 5 or more Attack. Reward: Barnabus.",2);
Insert into Card values (23,"Lakkari Sacrifice","Legendary","Ability",1,0,0,"Quest: Discard 6 cards. Reward: Nether Portal.",2);
Insert into Card values (24,"Open the Waygate","Legendary","Ability",1,0,0,"Quest: Cast 6 spells that didn't start in your deck. Reward: Time Warp.",2);
Insert into Card values (25,"The Caverns Below","Legendary","Ability",1,0,0,"Quest: Play five minions with the same name. Reward: Crystal Core.",2);
Insert into Card values (26,"The Last Kaleidosaur","Legendary","Ability",1,0,0,"Quest: Cast 6 spells on your minions. Reward: Galvadon.",2);
Insert into Card values (27,"The Marsh Queen","Legendary","Ability",1,0,0,"Quest: Play seven 1-Cost minions. Reward: Queen Carnassa.",2);
Insert into Card values (28,"Unite the Murlocs","Legendary","Ability",1,0,0,"Quest: Summon 10 Murlocs. Reward: Megafin.",2);
Insert into Card values (29,"Deathwing","Legendary","Minion",10,12,12,"Battlecry: Destroy all other minions and discard your hand.",1);
Insert into Card values (30,"Emeriss","Legendary","Minion",10,8,8,"Battlecry: Double the Attack and Health of all minions in_your hand.",5);
Insert into Card values (31,"Tyrantus","Legendary","Minion",10,12,12,"Can't be targeted by spells or Hero Powers.",2);
Insert into Card values (32,"Alexstrasza","Legendary","Minion",9,8,8,"Battlecry: Set a hero's remaining Health to 15.",1);
Insert into Card values (33,"Baku the Mooneater","Legendary","Minion",9,7,8,"Start of Game: If your deck has only odd-Cost cards upgrade your Hero Power.",5);
Insert into Card values (34,"Cenarius","Legendary","Minion",9,5,8,"Choose One - Give your other minions +2/+2 or Summon two 2/2 Treants with Taunt.",1);
Insert into Card values (35,"Dragoncaller Alanna","Legendary","Minion",9,3,3,"Battlecry: Summon a 5/5 Dragon for each spell you cast this game that costs (5) or more.",4);
Insert into Card values (36,"Hadronox","Legendary","Minion",9,3,7,"Deathrattle: Summon your Taunt minions that died this game.",3);
Insert into Card values (37,"King Krush","Legendary","Minion",9,8,8,"Charge",1);
Insert into Card values (38,"King Mosh","Legendary","Minion",9,9,7,"Battlecry: Destroy all damaged minions.",2);
Insert into Card values (39,"Lord Jaraxxus","Legendary","Minion",9,3,15,"Battlecry: Destroy your hero and replace it with Lord Jaraxxus.",1);
Insert into Card values (40,"Malygos","Legendary","Minion",9,4,12,"Spell Damage +5",1);
Insert into Card values (41,"Master Oakheart","Legendary","Minion",9,5,5,"Battlecry: Recruit a 1 2 and 3-Attack minion.",4);
Insert into Card values (42,"Nozdormu","Legendary","Minion",9,8,8,"Players only have 15 seconds to take their turns.",1);
Insert into Card values (43,"Onyxia","Legendary","Minion",9,8,8,"Battlecry: Summon 1/1 Whelps until your side of the battlefield is full.",1);
Insert into Card values (44,"Ozruk","Legendary","Minion",9,5,5,"Taunt. Battlecry: Gain +5 Health for each Elemental you played last turn.",2);
Insert into Card values (45,"Shudderwock","Legendary","Minion",9,6,6,"Battlecry: Repeat all other Battlecries from cards you played  this game (targets chosen randomly).",5);
Insert into Card values (46,"Ysera","Legendary","Minion",9,4,12,"At the end of your turn add a Dream Card to your hand.",1);
Insert into Card values (47,"Al'Akir the Windlord","Legendary","Minion",8,3,5,"Charge Divine Shield Taunt Windfury",1);
Insert into Card values (48,"Geosculptor Yip","Legendary","Minion",8,4,8,"At the end of your turn summon a random minion with Cost equal to your Armor (up to 10).",4);
Insert into Card values (49,"Grommash Hellscream","Legendary","Minion",8,4,9,"Charge. Enrage: +6 Attack",1);
Insert into Card values (50,"Gruul","Legendary","Minion",8,7,7,"At the end of each turn gain +1/+1 .",1);
Insert into Card values (51,"Kalimos Primal Lord","Legendary","Minion",8,7,7,"Battlecry: If you played an Elemental last turn cast an Elemental Invocation.",2);
Insert into Card values (52,"Kathrena Winterwisp","Legendary","Minion",8,6,6,"Battlecry and Deathrattle: Recruit a Beast.",4);
Insert into Card values (53,"King Togwaggle","Legendary","Minion",8,5,5,"Battlecry: Swap decks with your opponent. Give them a Ransom spell to swap back.",4);
Insert into Card values (54,"Marin the Fox","Legendary","Minion",8,6,6,"Battlecry: Summon a 0/8 Treasure Chest for your opponent. (Break it for awesome loot!)",4);
Insert into Card values (55,"Rotface","Legendary","Minion",8,4,6,"After this minion survives damage summon a random Legendary minion.",3);
Insert into Card values (56,"Sindragosa","Legendary","Minion",8,8,8,"Battlecry: Summon two 0/1 Frozen Champions.",3);
Insert into Card values (57,"Splintergraft","Legendary","Minion",8,8,8,"Battlecry: Choose a friendly minion. Add a 10/10 copy to your hand that costs (10).",5);
Insert into Card values (58,"Tess Greymane","Legendary","Minion",8,6,6,"Battlecry: Replay every card from another class you've played this game (targets chosen randomly).",5);
Insert into Card values (59,"The Lich King","Legendary","Minion",8,8,8,"Taunt. At the end of your turn add a random Death Knight card to your hand.",3);
Insert into Card values (60,"Tirion Fordring","Legendary","Minion",8,6,6,"Divine Shield Taunt Deathrattle: Equip a 5/3 Ashbringer.",1);
Insert into Card values (61,"Archbishop Benedictus","Legendary","Minion",7,4,6,"Battlecry: Shuffle a copy of your opponent's deck into your deck.",3);
Insert into Card values (62,"Archmage Antonidas","Legendary","Minion",7,5,7,"Whenever you cast a spell add a 'Fireball' spell to your hand.",1);
Insert into Card values (63,"Azalina Soulthief","Legendary","Minion",7,3,3,"Battlecry: Replace your hand with a copy of your_opponent's.",5);
Insert into Card values (64,"Baron Geddon","Legendary","Minion",7,7,5,"At the end of your turn deal 2 damage to ALL other characters.",1);
Insert into Card values (65,"Blackhowl Gunspire","Legendary","Minion",7,3,8,"Can't attack. Whenever this minion takes damage deal 3 damage to a random enemy.",5);
Insert into Card values (66,"Countess Ashmore","Legendary","Minion",7,6,6,"Battlecry: Draw a Rush Lifesteal and Deathrattle card from your deck.",5);
Insert into Card values (67,"Lord Godfrey","Legendary","Minion",7,4,4,"Battlecry: Deal 2 damage to all other minions. If any die repeat this Battlecry.",5);
Insert into Card values (68,"Lynessa Sunsorrow","Legendary","Minion",7,1,1,"Battlecry: Cast each spell you cast on your minions this game on this one.",4);
Insert into Card values (69,"Prophet Velen","Legendary","Minion",7,7,7,"Double the damage and healing of your spells and Hero Power.",1);
Insert into Card values (70,"Swamp King Dred","Legendary","Minion",7,9,9,"After your opponent plays a minion attack it.",2);
Insert into Card values (71,"Temporus","Legendary","Minion",7,6,6,"Battlecry: Your opponent takes two turns. Then you take two turns.",4);
Insert into Card values (72,"Cairne Bloodhoof","Legendary","Minion",6,4,5,"Deathrattle: Summon a 4/5 Baine Bloodhoof.",1);
Insert into Card values (73,"Genn Greymane","Legendary","Minion",6,6,5,"Start of Game: If your deck has only even-Cost cards your starting Hero Power costs (1).",5);
Insert into Card values (74,"Glinda Crowskin","Legendary","Minion",6,3,7,"Minions in your hand have Echo.",5);
Insert into Card values (75,"Grumble Worldshaker","Legendary","Minion",6,7,7,"Battlecry: Return your other minions to your hand. They cost (1).",4);
Insert into Card values (76,"Hemet Jungle Hunter","Legendary","Minion",6,6,6,"Battlecry: Destroy all cards in your deck that cost (3) or less.",2);
Insert into Card values (77,"Hogger","Legendary","Minion",6,4,4,"At the end of your turn summon a 2/2 Gnoll with Taunt.",1);
Insert into Card values (78,"Illidan Stormrage","Legendary","Minion",6,7,5,"Whenever you play a card summon a 2/1 Flame of Azzinoth.",1);
Insert into Card values (79,"Lady in White","Legendary","Minion",6,5,5,"Battlecry: Cast 'Inner Fire' on every minion in your deck (set Attack equal to Health).",5);
Insert into Card values (80,"Moorabi","Legendary","Minion",6,4,4,"Whenever another minion is Frozen add a copy of it to your hand.",3);
Insert into Card values (81,"Rin the First Disciple","Legendary","Minion",6,3,6,"Taunt. Deathrattle: Add 'The First Seal' to your hand.",4);
Insert into Card values (82,"Sunkeeper Tarim","Legendary","Minion",6,3,7,"Taunt. Battlecry: Set all other minions' Attack and Health to 3.",2);
Insert into Card values (83,"The Beast","Legendary","Minion",6,9,7,"Deathrattle: Summon a 3/3 Finkle Einhorn for your opponent.",1);
Insert into Card values (84,"The Black Knight","Legendary","Minion",6,4,5,"Battlecry: Destroy an enemy minion with Taunt.",1);
Insert into Card values (85,"Toki Time-Tinker","Legendary","Minion",6,5,5,"Battlecry: Add a random Legendary minion from the past to your hand.",5);
Insert into Card values (86,"Blood-Queen Lana'thel","Legendary","Minion",5,1,6,"Lifesteal. Has +1 Attack for each card you've discarded this game.",3);
Insert into Card values (87,"Bolvar Fireblood","Legendary","Minion",5,1,7,"Divine Shield. After a friendly minion loses Divine Shield gain +2 Attack.",3);
Insert into Card values (88,"Captain Greenskin","Legendary","Minion",5,5,4,"Battlecry: Give your weapon +1/+1.",1);
Insert into Card values (89,"Darius Crowley","Legendary","Minion",5,4,4,"Rush. After this attacks and kills a minion gain +2/+2.",5);
Insert into Card values (90,"Dollmaster Dorian","Legendary","Minion",5,2,6,"Whenever you draw a minion summon a 1/1 copy of it.",5);
Insert into Card values (91,"Duskfallen Aviana","Legendary","Minion",5,3,7,"On each player's turn the first card played costs (0).",5);
Insert into Card values (92,"Elise the Trailblazer","Legendary","Minion",5,5,5,"Battlecry: Shuffle a sealed Un'Goro pack into your deck.",2);
Insert into Card values (93,"Harrison Jones","Legendary","Minion",5,5,4,"Battlecry: Destroy your opponent's weapon and draw cards equal to its Durability.",1);
Insert into Card values (94,"Ixlid Fungal Lord","Legendary","Minion",5,2,4,"After you play a minion summon a copy of it.",4);
Insert into Card values (95,"Leeroy Jenkins","Legendary","Minion",5,6,2,"Charge. Battlecry: Summon two 1/1 Whelps for your opponent.",1);
Insert into Card values (96,"Lyra the Sunshard","Legendary","Minion",5,3,5,"Whenever you cast a spell add a random Priest spell to your hand.",2);
Insert into Card values (97,"Prince Liam","Legendary","Minion",5,5,5,"Battlecry: Transform all  1-Cost cards in your deck into Legendary minions.",5);
Insert into Card values (98,"Arfus","Legendary","Minion",4,2,2,"Deathrattle: Add a random Death Knight card to your hand.",3);
Insert into Card values (99,"Houndmaster Shaw","Legendary","Minion",4,3,6,"Your other minions have Rush.",5);
Insert into Card values (100,"Lilian Voss","Legendary","Minion",4,4,5,"Battlecry: Replace spells in your hand with random spells (from your opponent's class).",3);
Insert into Card values (101,"Prince Valanar","Legendary","Minion",4,4,4,"Battlecry: If your deck has no 4-Cost cards gain Lifesteal and Taunt.",3);
Insert into Card values (102,"Professor Putricide","Legendary","Minion",4,5,4,"After you play a Secret put a random Hunter Secret into the battlefield.",3);
Insert into Card values (103,"Sherazin Corpse Flower","Legendary","Minion",4,5,3,"Deathrattle: Go dormant. Play 4 cards in a turn to revive this minion.",2);
Insert into Card values (104,"Spiritsinger Umbra","Legendary","Minion",4,3,4,"After you summon a minion trigger its Deathrattle effect.",2);
Insert into Card values (105,"The Darkness","Legendary","Minion",4,20,20,"Starts dormant. Battlecry: Shuffle 3 Candles into the enemy deck. When drawn this awakens.",4);
Insert into Card values (106,"The Glass Knight","Legendary","Minion",4,4,3,"Divine Shield. Whenever you restore Health gain Divine Shield.",5);
Insert into Card values (107,"The Voraxx","Legendary","Minion",4,3,3,"After you cast a spell on this minion summon a 1/1 Plant and cast another copy on it.",4);
Insert into Card values (108,"Edwin VanCleef","Legendary","Minion",3,2,2,"Combo: Gain +2/+2 for each other card you've played this turn.",1);
Insert into Card values (109,"Face Collector","Legendary","Minion",3,2,2,"Echo. Battlecry: Add a random Legendary minion to your hand.",5);
Insert into Card values (110,"King Mukla","Legendary","Minion",3,5,5,"Battlecry: Give your opponent 2 Bananas.",1);
Insert into Card values (111,"Prince Taldaram","Legendary","Minion",3,3,3,"Battlecry: If your deck has no 3-Cost cards transform into a 3/3 copy of a minion.",3);
Insert into Card values (112,"Sonya Shadowdancer","Legendary","Minion",3,2,2,"After a friendly minion dies add a 1/1 copy of it to your hand. It costs (1).",4);
Insert into Card values (113,"Tinkmaster Overspark","Legendary","Minion",3,3,3,"Battlecry: Transform another random minion into a 5/5 Devilsaur or a 1/1 Squirrel.",1);
Insert into Card values (114,"Zola the Gorgon","Legendary","Minion",3,2,2,"Battlecry: Choose a friendly minion. Add a Golden copy of it to your hand.",4);
Insert into Card values (115,"Archmage Arugal","Legendary","Minion",2,2,2,"Whenever you draw a minion add a copy of it to your hand.",5);
Insert into Card values (116,"Bloodmage Thalnos","Legendary","Minion",2,1,1,"Spell Damage +1. Deathrattle: Draw a card.",1);
Insert into Card values (117,"Clutchmother Zavas","Legendary","Minion",2,2,2,"Whenever you discard this give it +2/+2 and return it to your hand.",2);
Insert into Card values (118,"Lorewalker Cho","Legendary","Minion",2,0,4,"Whenever a player casts a spell put a copy into the other player’s hand.",1);
Insert into Card values (119,"Millhouse Manastorm","Legendary","Minion",2,4,4,"Battlecry: Enemy spells cost (0) next turn.",1);
Insert into Card values (120,"Nat Pagle","Legendary","Minion",2,0,4,"At the start of your turn you have a 50% chance to draw an extra card.",1);
Insert into Card values (121,"Prince Keleseth","Legendary","Minion",2,2,2,"Battlecry: If your deck has no 2-Cost cards give all minions in your deck +1/+1.",3);
Insert into Card values (122,"Pyros","Legendary","Minion",2,2,2,"Deathrattle: Return this to your hand as a 6/6 that costs (6).",2);
Insert into Card values (123,"Chameleos","Legendary","Minion",1,1,1,"Each turn this is in your hand transform it into a card your opponent is holding.",5);
Insert into Card values (124,"Gladiator's Longbow","Epic","Weapon",7,5,2,"Your hero is Immune while attacking.",1);
Insert into Card values (125,"Gorehowl","Epic","Weapon",7,7,1,"Attacking a minion costs 1 Attack instead of 1 Durability.",1);
Insert into Card values (126,"Doomhammer","Epic","Weapon",5,2,8,"Windfury Overload: (2)",1);
Insert into Card values (127,"Light's Sorrow","Epic","Weapon",4,1,4,"After a friendly minion loses Divine Shield gain +1 Attack.",3);
Insert into Card values (128,"Spectral Cutlass","Epic","Weapon",4,2,2,"Lifesteal. Whenever you play a card from another class gain +1 Durability.",5);
Insert into Card values (129,"Sword of Justice","Epic","Weapon",3,1,5,"After you summon a minion give it +1/+1 and this loses 1 Durability.",1);
Insert into Card values (130,"Bladed Gauntlet","Epic","Weapon",2,0,2,"Has Attack equal to your Armor. Can't attack heroes.",4);
Insert into Card values (131,"Pyroblast","Epic","Ability",10,0,0,"Deal 10 damage.",1);
Insert into Card values (132,"Ultimate Infestation","Epic","Ability",10,0,0,"Deal 5 damage. Draw 5 cards. Gain 5 Armor. Summon a 5/5 Ghoul.",3);
Insert into Card values (133,"Dinosize","Epic","Ability",8,0,0,"Set a minion's Attack and Health to 10.",2);
Insert into Card values (134,"Glacial Mysteries","Epic","Ability",8,0,0,"Put one of each Secret from your deck into the battlefield.",3);
Insert into Card values (135,"Lay on Hands","Epic","Ability",8,0,0,"Restore 8 Health. Draw 3 cards.",1);
Insert into Card values (136,"Twisting Nether","Epic","Ability",8,0,0,"Destroy all minions.",1);
Insert into Card values (137,"Crushing Walls","Epic","Ability",7,0,0,"Destroy your opponent's left and right-most minions.",4);
Insert into Card values (138,"Psychic Scream","Epic","Ability",7,0,0,"Shuffle all minions into your opponent's deck.",4);
Insert into Card values (139,"Avenging Wrath","Epic","Ability",6,0,0,"Deal 8 damage randomly split among all enemies.",1);
Insert into Card values (140,"Deadly Arsenal","Epic","Ability",6,0,0,"Reveal a weapon from your deck. Deal its Attack to all minions.",5);
Insert into Card values (141,"Embrace Darkness","Epic","Ability",6,0,0,"Choose an enemy minion. At the start of your turn gain control of it.",3);
Insert into Card values (142,"Meteor","Epic","Ability",6,0,0,"Deal 15 damage to a minion and 3 damage to adjacent ones.",2);
Insert into Card values (143,"To My Side!","Epic","Ability",6,0,0,"Summon an Animal Companion or 2 if your deck has no minions.",4);
Insert into Card values (144,"Bane of Doom","Epic","Ability",5,0,0,"Deal 2 damage to a character. If that kills it summon a random Demon.",1);
Insert into Card values (145,"Brawl","Epic","Ability",5,0,0,"Destroy all minions except one. (chosen randomly)",1);
Insert into Card values (146,"Deck of Wonders","Epic","Ability",5,0,0,"Shuffle 5 Scrolls into your deck. When drawn cast a random spell.",4);
Insert into Card values (147,"Dragon's Fury","Epic","Ability",5,0,0,"Reveal a spell from your deck. Deal damage equal to its Cost to all minions.",4);
Insert into Card values (148,"Force of Nature","Epic","Ability",5,0,0,"Summon three 2/2 Treants.",1);
Insert into Card values (149,"Level Up!","Epic","Ability",5,0,0,"Give your Silver Hand Recruits +2/+2 and Taunt.",4);
Insert into Card values (150,"Living Mana","Epic","Ability",5,0,0,"Transform your Mana Crystals into 2/2 minions. Recover the mana when they die.",2);
Insert into Card values (151,"Sudden Genesis","Epic","Ability",5,0,0,"Summon copies of your damaged minions.",2);
Insert into Card values (152,"Branching Paths","Epic","Ability",4,0,0,"Choose Twice - Draw a card Give your minions +1 Attack Gain 6 Armor.",4);
Insert into Card values (153,"Call to Arms","Epic","Ability",4,0,0,"Recruit 3 minions that cost (2) or less.",4);
Insert into Card values (154,"Cataclysm","Epic","Ability",4,0,0,"Destroy all minions. Discard your hand.",4);
Insert into Card values (155,"Mindgames","Epic","Ability",4,0,0,"Put a copy of a random minion from your opponent's deck into the battlefield.",1);
Insert into Card values (156,"WANTED!","Epic","Ability",4,0,0,"Deal 3 damage to a minion. If that kills it add a Coin to your hand.",5);
Insert into Card values (157,"Wispering Woods","Epic","Ability",4,0,0,"Summon a 1/1 Wisp for each card in your hand.",5);
Insert into Card values (158,"Far Sight","Epic","Ability",3,0,0,"Draw a card. That card costs (3) less.",1);
Insert into Card values (159,"Reckless Flurry","Epic","Ability",3,0,0,"Spend all your Armor. Deal that much damage to all minions.",4);
Insert into Card values (160,"Shadowform","Epic","Ability",3,0,0,"Your Hero Power becomes 'Deal 2 damage'. If already in Shadowform: 3 damage.",1);
Insert into Card values (161,"Simulacrum","Epic","Ability",3,0,0,"Copy the lowest Cost minion in your hand.",3);
Insert into Card values (162,"Spellbender","Epic","Ability",3,0,0,"Secret: When an enemy casts a spell on a minion summon a 1/3 as the new target.",1);
Insert into Card values (163,"Spirit Echo","Epic","Ability",3,0,0,"Give your minions Deathrattle: Return this to your hand.",2);
Insert into Card values (164,"Treachery","Epic","Ability",3,0,0,"Choose a friendly minion and give it to your opponent.",3);
Insert into Card values (165,"Vivid Nightmare","Epic","Ability",3,0,0,"Choose a friendly minion. Summon a copy of it with 1 Health remaining.",5);
Insert into Card values (166,"Bloodbloom","Epic","Ability",2,0,0,"The next spell you cast this turn costs Health instead of Mana.",2);
Insert into Card values (167,"Book of Specters","Epic","Ability",2,0,0,"Draw 3 cards. Discard any spells drawn.",5);
Insert into Card values (168,"Bring It On!","Epic","Ability",2,0,0,"Gain 10 Armor. Reduce the Cost of minions in your opponent's hand by (2).",3);
Insert into Card values (169,"Cryostasis","Epic","Ability",2,0,0,"Give a minion +3/+3 and Freeze it.",3);
Insert into Card values (170,"Dead Man's Hand","Epic","Ability",2,0,0,"Shuffle a copy of your hand into your deck.",3);
Insert into Card values (171,"Dinomancy","Epic","Ability",2,0,0,"Your Hero Power becomes 'Give a Beast +2/+2.'",2);
Insert into Card values (172,"Evasion","Epic","Ability",2,0,0,"Secret: After your hero takes damage become Immune this turn.",4);
Insert into Card values (173,"Explore Un'Goro","Epic","Ability",2,0,0,"Replace your deck with copies of Discover a card.",2);
Insert into Card values (174,"Primordial Glyph","Epic","Ability",2,0,0,"Discover a spell. Reduce its Cost by (2).",2);
Insert into Card values (175,"Rat Trap","Epic","Ability",2,0,0,"Secret: After your opponent plays three cards in a turn summon a 6/6 Rat.",5);
Insert into Card values (176,"Shadow Visions","Epic","Ability",2,0,0,"Discover a copy of a spell in your deck.",2);
Insert into Card values (177,"Snake Trap","Epic","Ability",2,0,0,"Secret: When one of your minions is attacked summon three 1/1 Snakes.",1);
Insert into Card values (178,"Toxic Arrow","Epic","Ability",2,0,0,"Deal 2 damage to a minion. If it survives give it Poisonous.",3);
Insert into Card values (179,"Bestial Wrath","Epic","Ability",1,0,0,"Give a friendly Beast +2 Attack and Immune this turn.",1);
Insert into Card values (180,"Doomerang","Epic","Ability",1,0,0,"Throw your weapon at a minion. It deals its damage then returns to your hand.",3);
Insert into Card values (181,"Hidden Wisdom","Epic","Ability",1,0,0,"Secret: After your opponent plays three cards in a turn draw 2 cards.",5);
Insert into Card values (182,"Shield Slam","Epic","Ability",1,0,0,"Deal 1 damage to a minion for each Armor you have.",1);
Insert into Card values (183,"Stampede","Epic","Ability",1,0,0,"Each time you play a Beast this turn add a random Beast to your hand.",2);
Insert into Card values (184,"Unstable Evolution","Epic","Ability",1,0,0,"Transform a friendly minion into one that costs (1) more. Repeatable this turn.",4);
Insert into Card values (185,"Preparation","Epic","Ability",0,0,0,"The next spell you cast this turn costs (3) less.",1);
Insert into Card values (186,"Mountain Giant","Epic","Minion",12,8,8,"Costs (1) less for each other card in your hand.",1);
Insert into Card values (187,"Snowfury Giant","Epic","Minion",11,8,8,"Costs (1) less for each Mana Crystal you've Overloaded this game.",3);
Insert into Card values (188,"Sea Giant","Epic","Minion",10,8,8,"Costs (1) less for each other minion on the battlefield.",1);
Insert into Card values (189,"Dragonhatcher","Epic","Minion",9,2,4,"At the end of your turn Recruit a Dragon.",4);
Insert into Card values (190,"Obsidian Statue","Epic","Minion",9,4,8,"Taunt Lifesteal Deathrattle: Destroy a random enemy minion.",3);
Insert into Card values (191,"Voidlord","Epic","Minion",9,3,9,"Taunt Deathrattle: Summon three 1/3 Demons with Taunt.",4);
Insert into Card values (192,"Charged Devilsaur","Epic","Minion",8,7,7,"Charge. Battlecry: Can't attack heroes this turn.",2);
Insert into Card values (193,"Grand Archivist","Epic","Minion",8,4,7,"At the end of your turn cast a spell from your deck (targets chosen randomly).",4);
Insert into Card values (194,"Primordial Drake","Epic","Minion",8,4,8,"Taunt. Battlecry: Deal 2 damage to all other minions.",2);
Insert into Card values (195,"Splitting Festeroot","Epic","Minion",8,4,4,"Deathrattle: Summon two 2/2 Splitting Saplings.",5);
Insert into Card values (196,"Tortollan Primalist","Epic","Minion",8,5,4,"Battlecry: Discover a spell and cast it with random targets.",2);
Insert into Card values (197,"Abominable Bowman","Epic","Minion",7,6,7,"Deathrattle: Summon a random friendly Beast that died this game.",3);
Insert into Card values (198,"Ancient of Lore","Epic","Minion",7,5,5,"Choose One - Draw a card or Restore 5 Health.",1);
Insert into Card values (199,"Ancient of War","Epic","Minion",7,5,5,"Choose One - +5 Attack or +5 Health and Taunt.",1);
Insert into Card values (200,"Blazecaller","Epic","Minion",7,6,6,"Battlecry: If you played an Elemental last turn deal 5 damage.",2);
Insert into Card values (201,"Bogshaper","Epic","Minion",7,4,8,"Whenever you cast a spell draw a minion from your deck.",5);
Insert into Card values (202,"Corridor Creeper","Epic","Minion",7,2,5,"Costs (1) less whenever a minion dies while this is in your hand.",4);
Insert into Card values (203,"Giant Anaconda","Epic","Minion",7,5,3,"Deathrattle: Summon a minion from your hand with 5 or more Attack.",2);
Insert into Card values (204,"Stone Sentinel","Epic","Minion",7,4,4,"Battlecry: If you played an Elemental last turn summon two 2/3 Elementals with Taunt.",2);
Insert into Card values (205,"Worgen Abomination","Epic","Minion",7,6,6,"At the end of your turn deal 2 damage to all other damaged minions.",5);
Insert into Card values (206,"Blackguard","Epic","Minion",6,3,9,"Whenever your hero is healed deal that much damage to a random enemy minion.",3);
Insert into Card values (207,"Cabal Shadow Priest","Epic","Minion",6,4,5,"Battlecry: Take control of an enemy minion that has 2 or less Attack.",1);
Insert into Card values (208,"Furnacefire Colossus","Epic","Minion",6,6,6,"Battlecry: Discard all weapons from your hand and gain their stats.",3);
Insert into Card values (209,"Kidnapper","Epic","Minion",6,5,3,"Combo: Return a minion to its owner's hand.",1);
Insert into Card values (210,"Mossy Horror","Epic","Minion",6,2,7,"Battlecry: Destroy all other minions with 2 or less Attack.",5);
Insert into Card values (211,"Nerubian Unraveler","Epic","Minion",6,5,5,"Spells cost (2) more.",3);
Insert into Card values (212,"Skulking Geist","Epic","Minion",6,4,6,"Battlecry: Destroy all 1-Cost spells in both hands and decks.",3);
Insert into Card values (213,"Spectral Pillager","Epic","Minion",6,5,5,"Combo: Deal damage equal to the number of other cards you've played this turn.",3);
Insert into Card values (214,"Spiteful Summoner","Epic","Minion",6,4,4,"Battlecry: Reveal a spell from your deck. Summon a random minion with the same Cost.",4);
Insert into Card values (215,"Arcane Tyrant","Epic","Minion",5,4,4,"Costs (0) if you've cast a spell that costs (5) or more this turn.",4);
Insert into Card values (216,"Big Game Hunter","Epic","Minion",5,4,2,"Battlecry: Destroy a minion with 7 or more Attack.",1);
Insert into Card values (217,"Bittertide Hydra","Epic","Minion",5,8,8,"Whenever this minion takes damage deal 3 damage to your hero.",2);
Insert into Card values (218,"Carnivorous Cube","Epic","Minion",5,4,6,"Battlecry: Destroy a friendly minion. Deathrattle: Summon 2 copies of it.",4);
Insert into Card values (219,"Deathweb Spider","Epic","Minion",5,4,6,"Battlecry: If your hero took damage this turn gain Lifesteal.",5);
Insert into Card values (220,"Earth Elemental","Epic","Minion",5,7,8,"Taunt. Overload: (3)",1);
Insert into Card values (221,"Faceless Manipulator","Epic","Minion",5,3,3,"Battlecry: Choose a minion and become a copy of it.",1);
Insert into Card values (222,"Fatespinner","Epic","Minion",5,5,3,"Choose a Deathrattle (Secretly) - Deal 3 damage to all minions or Give them +2/+2.",3);
Insert into Card values (223,"Glitter Moth","Epic","Minion",5,4,4,"Battlecry: If your deck has only odd-Cost cards double the Health of your other minions.",5);
Insert into Card values (224,"Gloom Stag","Epic","Minion",5,2,6,"Taunt. Battlecry: If your deck has only odd-Cost cards gain +2/+2.",5);
Insert into Card values (225,"Muck Hunter","Epic","Minion",5,5,8,"Rush. Battlecry: Summon two 2/1 Mucklings for your opponent.",5);
Insert into Card values (226,"Tomb Lurker","Epic","Minion",5,5,3,"Battlecry: Add a random Deathrattle minion that died this game to your hand.",3);
Insert into Card values (227,"Vilespine Slayer","Epic","Minion",5,3,4,"Combo: Destroy a minion.",2);
Insert into Card values (228,"Windshear Stormcaller","Epic","Minion",5,5,5,"Battlecry: If you control all 4 basic Totems summon Al'Akir the Windlord.",4);
Insert into Card values (229,"Arcane Keysmith","Epic","Minion",4,2,2,"Battlecry: Discover a Secret. Put it into the battlefield.",5);
Insert into Card values (230,"Astral Tiger","Epic","Minion",4,3,5,"Deathrattle: Shuffle a copy of this minion into your deck.",4);
Insert into Card values (231,"Bright-Eyed Scout","Epic","Minion",4,3,4,"Battlecry: Draw a card. Change its Cost to (5).",2);
Insert into Card values (232,"Corpsetaker","Epic","Minion",4,3,3,"Battlecry: Gain Taunt if your deck has a Taunt minion. Repeat for Divine Shield Lifesteal Windfury.",3);
Insert into Card values (233,"Deathaxe Punisher","Epic","Minion",4,3,3,"Battlecry: Give a random Lifesteal minion in your hand +2/+2.",3);
Insert into Card values (234,"Fal'dorei Strider","Epic","Minion",4,4,4,"Battlecry: Shuffle 3 Ambushes into your deck. When drawn summon a 4/4 Spider.",4);
Insert into Card values (235,"Gentle Megasaur","Epic","Minion",4,5,4,"Battlecry: Adapt your Murlocs.",2);
Insert into Card values (236,"Meat Wagon","Epic","Minion",4,1,4,"Deathrattle: Summon a minion from your deck with less Attack than this minion.",3);
Insert into Card values (237,"Pit Lord","Epic","Minion",4,5,6,"Battlecry: Deal 5 damage to your hero.",1);
Insert into Card values (238,"Rattling Rascal","Epic","Minion",4,2,2,"Battlecry: Summon a 5/5 Skeleton. Deathrattle: Summon one for your opponent.",3);
Insert into Card values (239,"Sandbinder","Epic","Minion",4,2,4,"Battlecry: Draw an Elemental from your deck.",5);
Insert into Card values (240,"Shimmering Courser","Epic","Minion",4,3,3,"Only you can target this with spells and Hero Powers.",4);
Insert into Card values (241,"Totem Cruncher","Epic","Minion",4,2,3,"Taunt. Battlecry: Destroy your Totems. Gain +2/+2 for each destroyed.",5);
Insert into Card values (242,"Toxmonger","Epic","Minion",4,2,4,"Whenever you play a 1-Cost minion give it Poisonous.",5);
Insert into Card values (243,"Blood Knight","Epic","Minion",3,3,3,"Battlecry: All minions lose Divine Shield. Gain +3/+3 for each Shield lost.",1);
Insert into Card values (244,"Chittering Tunneler","Epic","Minion",3,3,3,"Battlecry: Discover a spell. Deal damage to your hero equal to its Cost.",2);
Insert into Card values (245,"Curious Glimmerroot","Epic","Minion",3,3,3,"Battlecry: Look at 3 cards. Guess which one started in your opponent's deck to get a copy of it.",2);
Insert into Card values (246,"Drakkari Enchanter","Epic","Minion",3,1,5,"Your end of turn effects trigger twice.",3);
Insert into Card values (247,"Gluttonous Ooze","Epic","Minion",3,3,3,"Battlecry: Destroy your opponent's weapon and gain Armor equal to its Attack.",2);
Insert into Card values (248,"Murloc Warleader","Epic","Minion",3,3,3,"Your other Murlocs have +2 Attack.",1);
Insert into Card values (249,"Nightmare Amalgam","Epic","Minion",3,3,4,"This is an Elemental Mech Demon Murloc Dragon Beast Pirate and Totem.",5);
Insert into Card values (250,"Ratcatcher","Epic","Minion",3,2,2,"Rush. Battlecry: Destroy a friendly minion and gain its Attack and Health.",5);
Insert into Card values (251,"Rummaging Kobold","Epic","Minion",3,1,3,"Battlecry: Return one of your destroyed weapons to your hand.",4);
Insert into Card values (252,"Southsea Captain","Epic","Minion",3,3,3,"Your other Pirates have +1/+1.",1);
Insert into Card values (253,"Twilight Acolyte","Epic","Minion",3,2,4,"Battlecry: If you're holding a Dragon swap this minion's Attack with another minion's.",4);
Insert into Card values (254,"Void Ripper","Epic","Minion",3,3,3,"Battlecry: Swap the Attack and Health of all other minions.",4);
Insert into Card values (255,"Voodoo Doll","Epic","Minion",3,1,1,"Battlecry: Choose a minion. Deathrattle: Destroy the chosen minion.",5);
Insert into Card values (256,"Witch's Cauldron","Epic","Minion",3,0,4,"After a friendly minion dies add a random Shaman spell to your hand.",5);
Insert into Card values (257,"Baleful Banker","Epic","Minion",2,2,2,"Battlecry: Choose a friendly minion. Shuffle a copy of it into your deck.",5);
Insert into Card values (258,"Biteweed","Epic","Minion",2,1,1,"Combo: Gain +1/+1 for each other card you've played this turn.",2);
Insert into Card values (259,"Cathedral Gargoyle","Epic","Minion",2,2,2,"Battlecry: If you're holding a Dragon gain Taunt and Divine Shield.",5);
Insert into Card values (260,"Doomsayer","Epic","Minion",2,0,7,"At the start of your turn destroy ALL minions.",1);
Insert into Card values (261,"Gnomeferatu","Epic","Minion",2,2,3,"Battlecry: Remove the top card of your opponent's deck.",3);
Insert into Card values (262,"Patient Assassin","Epic","Minion",2,1,1,"Stealth. Poisonous",1);
Insert into Card values (263,"Primalfin Champion","Epic","Minion",2,1,2,"Deathrattle: Return any spells you cast on this minion to your hand.",2);
Insert into Card values (264,"Emerald Hive Queen","Epic","Minion",1,2,3,"Your minions cost (2) more.",2);
Insert into Card values (265,"Hungry Crab","Epic","Minion",1,1,2,"Battlecry: Destroy a Murloc and gain +2/+2.",1);
Insert into Card values (266,"Town Crier","Epic","Minion",1,1,2,"Battlecry: Draw a Rush minion from your deck.",5);
Insert into Card values (267,"Silver Sword","Rare","Weapon",8,3,4,"After your hero attacks give your minions +1/+1.",5);
Insert into Card values (268,"Vinecleaver","Rare","Weapon",7,4,3,"After your hero attacks summon two 1/1 Silver Hand Recruits.",2);
Insert into Card values (269,"Obsidian Shard","Rare","Weapon",4,3,3,"Costs (1) less for each card you've played from another class.",2);
Insert into Card values (270,"Eaglehorn Bow","Rare","Weapon",3,3,2,"Whenever a friendly Secret is revealed gain +1 Durability.",1);
Insert into Card values (271,"Ice Breaker","Rare","Weapon",3,1,3,"Destroy any Frozen minion damaged by this.",3);
Insert into Card values (272,"Perdition's Blade","Rare","Weapon",3,2,2,"Battlecry: Deal 1 damage. Combo: Deal 2 instead.",1);
Insert into Card values (273,"Shadowblade","Rare","Weapon",3,3,2,"Battlecry: Your hero is Immune this turn.",3);
Insert into Card values (274,"Unidentified Maul","Rare","Weapon",3,2,2,"Gains a bonus effect in your hand.",4);
Insert into Card values (275,"Molten Blade","Rare","Weapon",1,1,1,"Each turn this is in your hand transform it into a new weapon.",2);
Insert into Card values (276,"Free From Amber","Rare","Ability",8,0,0,"Discover a minion that costs (8) or more. Summon it.",2);
Insert into Card values (277,"Lesser Diamond Spellstone","Rare","Ability",7,0,0,"Resurrect 2 different friendly minions. (Cast 4 spells to upgrade.)",4);
Insert into Card values (278,"Lesser Mithril Spellstone","Rare","Ability",7,0,0,"Summon one 5/5 Mithril Golem. (Equip a weapon to upgrade.)",4);
Insert into Card values (279,"Lesser Sapphire Spellstone","Rare","Ability",7,0,0,"Summon 1 copy of a friendly minion. (Overload 3 Mana Crystals to upgrade.)",4);
Insert into Card values (280,"Blizzard","Rare","Ability",6,0,0,"Deal 2 damage to all enemy minions and Freeze them.",1);
Insert into Card values (281,"Gather Your Party","Rare","Ability",6,0,0,"Recruit a minion.",4);
Insert into Card values (282,"Holy Fire","Rare","Ability",6,0,0,"Deal 5 damage. Restore 5 Health to your hero.",1);
Insert into Card values (283,"Shadow Essence","Rare","Ability",6,0,0,"Summon a 5/5 copy of a random minion in your deck.",3);
Insert into Card values (284,"Siphon Soul","Rare","Ability",6,0,0,"Destroy a minion. Restore 3 Health to your hero.",1);
Insert into Card values (285,"Spikeridged Steed","Rare","Ability",6,0,0,"Give a minion +2/+6 and Taunt. When it dies summon a Stegodon.",2);
Insert into Card values (286,"Spreading Plague","Rare","Ability",6,0,0,"Summon a 1/5 Scarab with Taunt. If your opponent has more minions cast this again.",3);
Insert into Card values (287,"Blessed Champion","Rare","Ability",5,0,0,"Double a minion's Attack.",1);
Insert into Card values (288,"Devour Mind","Rare","Ability",5,0,0,"Copy 3 cards in your opponent's deck and add them to your hand.",3);
Insert into Card values (289,"Explosive Shot","Rare","Ability",5,0,0,"Deal 5 damage to a minion and 2 damage to adjacent ones.",1);
Insert into Card values (290,"Feeding Time","Rare","Ability",5,0,0,"Deal 3 damage to a minion. Summon three 1/1 Pterrordaxes.",2);
Insert into Card values (291,"Holy Water","Rare","Ability",5,0,0,"Deal 4 damage to a minion. If that kills it add a copy of it to your hand.",5);
Insert into Card values (292,"Holy Wrath","Rare","Ability",5,0,0,"Draw a card and deal damage equal to its Cost.",1);
Insert into Card values (293,"Lesser Emerald Spellstone","Rare","Ability",5,0,0,"Summon two 3/3 Wolves. (Play a Secret to upgrade.)",4);
Insert into Card values (294,"Lesser Onyx Spellstone","Rare","Ability",5,0,0,"Destroy 1 random enemy minion. (Play 3 Deathrattle cards to upgrade.)",4);
Insert into Card values (295,"Nourish","Rare","Ability",5,0,0,"Choose One - Gain 2 Mana Crystals or Draw 3 cards.",1);
Insert into Card values (296,"Starfall","Rare","Ability",5,0,0,"Choose One - Deal 5 damage to a minion or 2 damage to all enemy minions.",1);
Insert into Card values (297,"Volcano","Rare","Ability",5,0,0,"Deal 15 damage randomly split among all minions. Overload: (2)",2);
Insert into Card values (298,"Avalanche","Rare","Ability",4,0,0,"Freeze a minion and deal 3 damage to adjacent ones.",3);
Insert into Card values (299,"Bite","Rare","Ability",4,0,0,"Give your hero +4 Attack this turn. Gain 4 Armor.",1);
Insert into Card values (300,"Blade Flurry","Rare","Ability",4,0,0,"Destroy your weapon and deal its damage to all enemy minions.",1);
Insert into Card values (301,"Eternal Servitude","Rare","Ability",4,0,0,"Discover a friendly minion that died this game. Summon it.",3);
Insert into Card values (302,"Evolving Spores","Rare","Ability",4,0,0,"Adapt your minions.",2);
Insert into Card values (303,"Lesser Amethyst Spellstone","Rare","Ability",4,0,0,"Lifesteal. Deal 3 damage to a minion. (Take damage from your cards to upgrade.)",4);
Insert into Card values (304,"Mass Dispel","Rare","Ability",4,0,0,"Silence all enemy minions. Draw a card.",1);
Insert into Card values (305,"Molten Reflection","Rare","Ability",4,0,0,"Choose a friendly minion. Summon a copy of it.",2);
Insert into Card values (306,"Mortal Strike","Rare","Ability",4,0,0,"Deal 4 damage. If you have 12 or less Health deal 6 instead.",1);
Insert into Card values (307,"Shadow Madness","Rare","Ability",4,0,0,"Gain control of an enemy minion with 3 or less Attack until end of turn.",1);
Insert into Card values (308,"Shadowflame","Rare","Ability",4,0,0,"Destroy a friendly minion and deal its Attack damage to all enemy minions.",1);
Insert into Card values (309,"Wing Blast","Rare","Ability",4,0,0,"Deal 4 damage to a minion. If a minion died this turn this costs (1).",5);
Insert into Card values (310,"Cinderstorm","Rare","Ability",3,0,0,"Deal 5 damage randomly split among all enemies.",5);
Insert into Card values (311,"Counterspell","Rare","Ability",3,0,0,"Secret: When your opponent casts a spell Counter it.",1);
Insert into Card values (312,"Divine Favor","Rare","Ability",3,0,0,"Draw cards until you have as many in hand as your opponent.",1);
Insert into Card values (313,"Envenom Weapon","Rare","Ability",3,0,0,"Give your weapon Poisonous.",2);
Insert into Card values (314,"Explosive Runes","Rare","Ability",3,0,0,"Secret: After your opponent plays a minion deal 6 damage to it and any excess to their hero.",4);
Insert into Card values (315,"Feral Spirit","Rare","Ability",3,0,0,"Summon two 2/3 Spirit Wolves with Taunt. Overload: (2)",1);
Insert into Card values (316,"Headcrack","Rare","Ability",3,0,0,"Deal 2 damage to the enemy hero. Combo: Return this to your hand next turn.",1);
Insert into Card values (317,"Lava Burst","Rare","Ability",3,0,0,"Deal 5 damage. Overload: (2)",1);
Insert into Card values (318,"Lightning Storm","Rare","Ability",3,0,0,"Deal 2-3 damage to all enemy minions. Overload: (2)",1);
Insert into Card values (319,"Mana Bind","Rare","Ability",3,0,0,"Secret: When your opponent casts a spell add a copy to your hand that costs (0).",2);
Insert into Card values (320,"Mimic Pod","Rare","Ability",3,0,0,"Draw a card then add a copy of it to your hand.",2);
Insert into Card values (321,"Primal Talismans","Rare","Ability",3,0,0,"Give your minions Deathrattle: Summon a random basic Totem.",4);
Insert into Card values (322,"Twilight's Call","Rare","Ability",3,0,0,"Summon 1/1 copies of 2 friendly Deathrattle minions that died this game.",4);
Insert into Card values (323,"Unwilling Sacrifice","Rare","Ability",3,0,0,"Choose a friendly minion. Destroy it and a random enemy minion.",3);
Insert into Card values (324,"Vaporize","Rare","Ability",3,0,0,"Secret: When a minion attacks your hero destroy it.",1);
Insert into Card values (325,"Witching Hour","Rare","Ability",3,0,0,"Summon a random friendly Beast that died this game.",5);
Insert into Card values (326,"Ancestral Spirit","Rare","Ability",2,0,0,"Give a minion Deathrattle: Resummon this minion.",1);
Insert into Card values (327,"Commanding Shout","Rare","Ability",2,0,0,"Your minions can't be reduced below 1 Health this turn. Draw a card.",1);
Insert into Card values (328,"Corrupting Mist","Rare","Ability",2,0,0,"Corrupt every minion. Destroy them at the start of your next turn.",2);
Insert into Card values (329,"Curse of Weakness","Rare","Ability",2,0,0,"Echo. Give all enemy minions -2 Attack until your next turn.",5);
Insert into Card values (330,"Defile","Rare","Ability",2,0,0,"Deal 1 damage to all minions. If any die cast this again.",3);
Insert into Card values (331,"Desperate Stand","Rare","Ability",2,0,0,"Give a minion Deathrattle: Return this to life with 1 Health.",3);
Insert into Card values (332,"Earthen Might","Rare","Ability",2,0,0,"Give a minion +2/+2. If it's an Elemental add a random Elemental to your hand.",5);
Insert into Card values (333,"Equality","Rare","Ability",2,0,0,"Change the Health of ALL minions to 1.",1);
Insert into Card values (334,"Flare","Rare","Ability",2,0,0,"All minions lose Stealth. Destroy all enemy Secrets. Draw a card.",1);
Insert into Card values (335,"Lesser Pearl Spellstone","Rare","Ability",2,0,0,"Summon a 2/2 Spirit with Taunt. (Restore 3 Health to upgrade.)",4);
Insert into Card values (336,"Lesser Ruby Spellstone","Rare","Ability",2,0,0,"Add 1 random Mage spell to your hand. (Play 2 Elementals to upgrade.)",4);
Insert into Card values (337,"Misdirection","Rare","Ability",2,0,0,"Secret: When an enemy attacks your hero instead it attacks another random character.",1);
Insert into Card values (338,"Pick Pocket","Rare","Ability",2,0,0,"Echo. Add a random card to your hand (from your opponent's class).",5);
Insert into Card values (339,"Roll the Bones","Rare","Ability",2,0,0,"Draw a card. If it has Deathrattle cast this again.",3);
Insert into Card values (340,"Venomstrike Trap","Rare","Ability",2,0,0,"Secret: When one of your minions is attacked summon a 2/3 Poisonous Cobra.",3);
Insert into Card values (341,"Wandering Monster","Rare","Ability",2,0,0,"Secret: When an enemy attacks your hero summon a 3-Cost minion as the new target.",4);
Insert into Card values (342,"Blazing Invocation","Rare","Ability",1,0,0,"Discover a Battlecry minion.",5);
Insert into Card values (343,"Dark Possession","Rare","Ability",1,0,0,"Deal 2 damage to a friendly character. Discover a Demon.",5);
Insert into Card values (344,"Earthen Scales","Rare","Ability",1,0,0,"Give a friendly minion +1/+1 then gain Armor equal to its Attack.",2);
Insert into Card values (345,"Lesser Jasper Spellstone","Rare","Ability",1,0,0,"Deal 2 damage to a minion. (Gain 3 Armor to upgrade.)",4);
Insert into Card values (346,"Savagery","Rare","Ability",1,0,0,"Deal damage equal to your hero's Attack to a minion.",1);
Insert into Card values (347,"Upgrade!","Rare","Ability",1,0,0,"If you have a weapon give it +1/+1. Otherwise equip a 1/3 weapon.",1);
Insert into Card values (348,"Gilnean Royal Guard","Rare","Minion",8,3,8,"Divine Shield Rush. Each turn this is in your hand swap its Attack and Health.",5);
Insert into Card values (349,"Grizzled Guardian","Rare","Minion",8,3,5,"Taunt Deathrattle: Recruit 2 minions that cost (4) or less.",4);
Insert into Card values (350,"Nightscale Matriarch","Rare","Minion",7,4,9,"Whenever a friendly minion is healed summon a 3/3 Whelp.",5);
Insert into Card values (351,"Ravenholdt Assassin","Rare","Minion",7,7,5,"Stealth",1);
Insert into Card values (352,"Volcanosaur","Rare","Minion",7,5,6,"Battlecry: Adapt then Adapt.",2);
Insert into Card values (353,"Argent Commander","Rare","Minion",6,4,2,"Charge. Divine Shield.",1);
Insert into Card values (354,"Bone Drake","Rare","Minion",6,6,5,"Deathrattle: Add a random Dragon to your hand.",3);
Insert into Card values (355,"Coffin Crasher","Rare","Minion",6,6,5,"Deathrattle: Summon a Deathrattle minion from your hand.",5);
Insert into Card values (356,"Cruel Dinomancer","Rare","Minion",6,5,5,"Deathrattle: Summon a random minion you discarded this game.",2);
Insert into Card values (357,"Crystal Lion","Rare","Minion",6,5,5,"Divine Shield. Costs (1) less for each Silver Hand Recruit you control.",4);
Insert into Card values (358,"Cursed Castaway","Rare","Minion",6,5,3,"Rush. Deathrattle: Draw a Combo card from your deck.",5);
Insert into Card values (359,"Frozen Crusher","Rare","Minion",6,8,8,"After this minion attacks Freeze it.",2);
Insert into Card values (360,"Gadgetzan Auctioneer","Rare","Minion",6,4,4,"Whenever you cast a spell draw a card.",1);
Insert into Card values (361,"Hungry Ettin","Rare","Minion",6,4,10,"Taunt. Battlecry: Summon a random 2-Cost minion for your opponent.",4);
Insert into Card values (362,"Savannah Highmane","Rare","Minion",6,6,5,"Deathrattle: Summon two 2/2 Hyenas.",1);
Insert into Card values (363,"Seeping Oozeling","Rare","Minion",6,5,4,"Battlecry: Gain the Deathrattle of a random minion in your deck.",4);
Insert into Card values (364,"Sunwalker","Rare","Minion",6,4,5,"Taunt. Divine Shield",1);
Insert into Card values (365,"Abomination","Rare","Minion",5,4,4,"Taunt. Deathrattle: Deal 2 damage to ALL characters.",1);
Insert into Card values (366,"Bewitched Guardian","Rare","Minion",5,4,1,"Taunt. Battlecry: Gain +1 Health for each card in your hand.",5);
Insert into Card values (367,"Bonfire Elemental","Rare","Minion",5,5,5,"Battlecry: If you played an Elemental last turn draw a card.",5);
Insert into Card values (368,"Carrion Drake","Rare","Minion",5,3,7,"Battlecry: If a minion died this turn gain Poisonous.",5);
Insert into Card values (369,"Chief Inspector","Rare","Minion",5,4,6,"Battlecry: Destroy all enemy Secrets.",5);
Insert into Card values (370,"Corpse Raiser","Rare","Minion",5,3,3,"Battlecry: Give a friendly minion Deathrattle: Resummon this minion.",3);
Insert into Card values (371,"Corpse Widow","Rare","Minion",5,4,6,"Your Deathrattle cards cost (2) less.",3);
Insert into Card values (372,"Curio Collector","Rare","Minion",5,4,4,"Whenever you draw a card gain +1/+1.",5);
Insert into Card values (373,"Death Revenant","Rare","Minion",5,3,3,"Battlecry: Gain +1/+1 for each damaged minion.",3);
Insert into Card values (374,"Despicable Dreadlord","Rare","Minion",5,4,5,"At the end of your turn deal 1 damage to all enemy minions.",3);
Insert into Card values (375,"Direhorn Hatchling","Rare","Minion",5,3,6,"Taunt. Deathrattle: Shuffle a 6/9 Direhorn with Taunt into your deck.",2);
Insert into Card values (376,"Doomguard","Rare","Minion",5,5,7,"Charge. Battlecry: Discard two random cards.",1);
Insert into Card values (377,"Festeroot Hulk","Rare","Minion",5,2,7,"After a friendly minion attacks gain +1 Attack.",5);
Insert into Card values (378,"Furbolg Mossbinder","Rare","Minion",5,1,1,"Battlecry: Transform a friendly minion into a 6/6 Elemental.",4);
Insert into Card values (379,"Possessed Lackey","Rare","Minion",5,2,2,"Deathrattle: Recruit a Demon.",4);
Insert into Card values (380,"Servant of Kalimos","Rare","Minion",5,4,5,"Battlecry: If you played an Elemental last turn Discover an Elemental.",2);
Insert into Card values (381,"Stampeding Kodo","Rare","Minion",5,3,5,"Battlecry: Destroy a random enemy minion with 2 or less Attack.",1);
Insert into Card values (382,"Tol'vir Warden","Rare","Minion",5,3,5,"Battlecry: Draw two 1-Cost minions from your deck.",2);
Insert into Card values (383,"Voodoo Hexxer","Rare","Minion",5,2,7,"Taunt. Freeze any character damaged by this minion.",3);
Insert into Card values (384,"Witchwood Grizzly","Rare","Minion",5,3,12,"Taunt. Battlecry: Lose 1 Health for each card in your opponent's hand.",5);
Insert into Card values (385,"Ancient Mage","Rare","Minion",4,2,5,"Battlecry: Give adjacent minions Spell Damage +1.",1);
Insert into Card values (386,"Arrogant Crusader","Rare","Minion",4,5,2,"Deathrattle: If it's your opponent's turn summon a 2/2 Ghoul.",3);
Insert into Card values (387,"Auchenai Soulpriest","Rare","Minion",4,3,5,"Your cards and powers that restore Health now deal damage instead.",1);
Insert into Card values (388,"Bellringer Sentry","Rare","Minion",4,3,4,"Battlecry and Deathrattle: Put a Secret from your deck into the battlefield.",5);
Insert into Card values (389,"Blood Witch","Rare","Minion",4,3,6,"At the start of your turn deal 1 damage to your hero.",5);
Insert into Card values (390,"Defender of Argus","Rare","Minion",4,2,3,"Battlecry: Give adjacent minions +1/+1 and Taunt.",1);
Insert into Card values (391,"Duskbreaker","Rare","Minion",4,3,3,"Battlecry: If you're holding a Dragon deal 3 damage to all other minions.",4);
Insert into Card values (392,"Ebon Dragonsmith","Rare","Minion",4,3,4,"Battlecry: Reduce the Cost of a random weapon in your hand by (2).",4);
Insert into Card values (393,"Elven Minstrel","Rare","Minion",4,3,2,"Combo: Draw 2 minions from your deck.",4);
Insert into Card values (394,"Ethereal Arcanist","Rare","Minion",4,3,3,"If you control a Secret at the end of your turn gain +2/+2.",1);
Insert into Card values (395,"Exploding Bloatbat","Rare","Minion",4,2,1,"Deathrattle: Deal 2 damage to all enemy minions.",3);
Insert into Card values (396,"Forest Guide","Rare","Minion",4,1,6,"At the end of your turn both players draw a card.",5);
Insert into Card values (397,"Ghastly Conjurer","Rare","Minion",4,2,6,"Battlecry: Add a 'Mirror Image' spell to your hand.",3);
Insert into Card values (398,"Hooked Reaver","Rare","Minion",4,4,4,"Battlecry: If you have 15 or less Health gain +3/+3 and Taunt.",4);
Insert into Card values (399,"Keening Banshee","Rare","Minion",4,5,5,"Whenever you play a card remove the top 3 cards of your deck.",3);
Insert into Card values (400,"Keeper of the Grove","Rare","Minion",4,2,2,"Choose One - Deal 2 damage or Silence a minion.",1);
Insert into Card values (401,"Kobold Illusionist","Rare","Minion",4,3,3,"Deathrattle: Summon a 1/1 copy of a minion from your hand.",4);
Insert into Card values (402,"Kobold Monk","Rare","Minion",4,3,6,"Your hero can't be targeted by spells or Hero Powers.",4);
Insert into Card values (403,"Leyline Manipulator","Rare","Minion",4,4,5,"Battlecry: If you're holding any cards that didn't start in your deck reduce their Cost by (2).",4);
Insert into Card values (404,"Lifedrinker","Rare","Minion",4,3,3,"Battlecry: Deal 3 damage to the enemy hero. Restore 3 Health to your hero.",5);
Insert into Card values (405,"Lightfused Stegodon","Rare","Minion",4,3,4,"Battlecry: Adapt your Silver Hand Recruits.",2);
Insert into Card values (406,"Mad Hatter","Rare","Minion",4,3,2,"Battlecry: Randomly toss 3 hats to other minions. Each hat gives +1/+1.",5);
Insert into Card values (407,"Master of Disguise","Rare","Minion",4,4,4,"Battlecry: Give a friendly minion Stealth until your next turn.",1);
Insert into Card values (408,"Militia Commander","Rare","Minion",4,2,5,"Rush. Battlecry: Gain +3 Attack this turn.",5);
Insert into Card values (409,"Mistwraith","Rare","Minion",4,3,5,"Whenever you play an Echo card gain +1/+1.",5);
Insert into Card values (410,"Night Prowler","Rare","Minion",4,3,3,"Battlecry: If this is the only minion in the battlefield gain +3/+3.",5);
Insert into Card values (411,"Phantom Freebooter","Rare","Minion",4,3,3,"Battlecry: Gain stats equal to your weapon's.",3);
Insert into Card values (412,"Runeforge Haunter","Rare","Minion",4,5,3,"During your turn your weapon doesn't lose Durability.",3);
Insert into Card values (413,"Saronite Chain Gang","Rare","Minion",4,2,3,"Taunt. Battlecry: Summon a copy of this minion.",3);
Insert into Card values (414,"Scaleworm","Rare","Minion",4,4,4,"Battlecry: If you're holding a Dragon gain +1 Attack and Rush.",5);
Insert into Card values (415,"Shellshifter","Rare","Minion",4,3,3,"Choose One - Transform into a 5/3 with Stealth or a 3/5 with Taunt.",2);
Insert into Card values (416,"Steam Surger","Rare","Minion",4,5,4,"Battlecry: If you played an Elemental last turn add a 'Flame Geyser' to your hand.",2);
Insert into Card values (417,"Strongshell Scavenger","Rare","Minion",4,2,3,"Battlecry: Give your Taunt minions +2/+2.",3);
Insert into Card values (418,"Ticking Abomination","Rare","Minion",4,5,6,"Deathrattle: Deal 5 damage to your minions.",3);
Insert into Card values (419,"Tol'vir Stoneshaper","Rare","Minion",4,3,5,"Battlecry: If you played an Elemental last turn gain Taunt and Divine Shield.",2);
Insert into Card values (420,"Twilight Drake","Rare","Minion",4,4,1,"Battlecry: Gain +1 Health for each card in your hand.",1);
Insert into Card values (421,"Violet Teacher","Rare","Minion",4,3,5,"Whenever you cast a spell summon a 1/1 Violet Apprentice.",1);
Insert into Card values (422,"Witchwood Piper","Rare","Minion",4,3,3,"Battlecry: Draw the lowest Cost minion from your deck.",5);
Insert into Card values (423,"Alarm-o-Bot","Rare","Minion",3,0,3,"At the start of your turn swap this minion with a random one in your hand.",1);
Insert into Card values (424,"Aldor Peacekeeper","Rare","Minion",3,3,3,"Battlecry: Change an enemy minion's Attack to 1.",1);
Insert into Card values (425,"Arcane Golem","Rare","Minion",3,4,4,"Battlecry: Give your opponent a Mana Crystal.",1);
Insert into Card values (426,"Coldlight Seer","Rare","Minion",3,2,3,"Battlecry: Give your other Murlocs +2 Health.",1);
Insert into Card values (427,"Demolisher","Rare","Minion",3,1,4,"At the start of your turn deal 2 damage to a random enemy.",1);
Insert into Card values (428,"Devilsaur Egg","Rare","Minion",3,0,3,"Deathrattle: Summon a 5/5 Devilsaur.",2);
Insert into Card values (429,"Doomed Apprentice","Rare","Minion",3,3,2,"Your opponent's spells cost (1) more.",3);
Insert into Card values (430,"Duskhaven Hunter","Rare","Minion",3,2,5,"Stealth Each turn this is in your hand swap its Attack and Health.",5);
Insert into Card values (431,"Emperor Cobra","Rare","Minion",3,2,3,"Poisonous",1);
Insert into Card values (432,"Felguard","Rare","Minion",3,3,5,"Taunt. Battlecry: Destroy one of your Mana Crystals.",1);
Insert into Card values (433,"Frothing Berserker","Rare","Minion",3,2,4,"Whenever a minion takes damage gain +1 Attack.",1);
Insert into Card values (434,"Greedy Sprite","Rare","Minion",3,3,1,"Deathrattle: Gain an empty Mana Crystal.",4);
Insert into Card values (435,"Happy Ghoul","Rare","Minion",3,3,3,"Costs (0) if your hero was healed this turn.",3);
Insert into Card values (436,"Howling Commander","Rare","Minion",3,2,2,"Battlecry: Draw a Divine Shield minion from your deck.",3);
Insert into Card values (437,"Humongous Razorleaf","Rare","Minion",3,4,8,"Can't attack.",2);
Insert into Card values (438,"Imp Master","Rare","Minion",3,1,5,"At the end of your turn deal 1 damage to this minion and summon a 1/1 Imp.",1);
Insert into Card values (439,"Injured Blademaster","Rare","Minion",3,4,7,"Battlecry: Deal 4 damage to HIMSELF.",1);
Insert into Card values (440,"Kirin Tor Mage","Rare","Minion",3,4,3,"Battlecry: The next Secret you play this turn costs (0).",1);
Insert into Card values (441,"Kobold Barbarian","Rare","Minion",3,4,4,"At the start of your turn attack a random enemy.",4);
Insert into Card values (442,"Lone Champion","Rare","Minion",3,2,4,"Battlecry: If you control no other minions gain Taunt and Divine Shield.",4);
Insert into Card values (443,"Mana Tide Totem","Rare","Minion",3,0,3,"At the end of your turn draw a card.",1);
Insert into Card values (444,"Mind Control Tech","Rare","Minion",3,3,3,"Battlecry: If your opponent has 4 or more minions take control of one at random.",1);
Insert into Card values (445,"Mindbreaker","Rare","Minion",3,2,5,"Hero Powers are disabled.",3);
Insert into Card values (446,"Mirage Caller","Rare","Minion",3,2,3,"Battlecry: Choose a friendly minion. Summon a 1/1 copy of it.",2);
Insert into Card values (447,"Mountainfire Armor","Rare","Minion",3,4,3,"Deathrattle: If it's your opponent's turn gain 6 Armor.",3);
Insert into Card values (448,"Paragon of Light","Rare","Minion",3,2,5,"While this minion has 3 or more Attack it has Taunt and Lifesteal.",5);
Insert into Card values (449,"Phantom Militia","Rare","Minion",3,2,4,"Echo. Taunt",5);
Insert into Card values (450,"Questing Adventurer","Rare","Minion",3,2,2,"Whenever you play a card gain +1/+1.",1);
Insert into Card values (451,"Shallow Gravedigger","Rare","Minion",3,3,1,"Deathrattle: Add a random Deathrattle minion to your hand.",3);
Insert into Card values (452,"Shrieking Shroom","Rare","Minion",3,1,2,"At the end of your turn summon a random 1-Cost minion.",4);
Insert into Card values (453,"SI:7 Agent","Rare","Minion",3,3,3,"Combo: Deal 2 damage.",1);
Insert into Card values (454,"Stonehill Defender","Rare","Minion",3,1,4,"Taunt. Battlecry: Discover a Taunt minion.",2);
Insert into Card values (455,"Terrorscale Stalker","Rare","Minion",3,3,3,"Battlecry: Trigger a friendly minion's Deathrattle.",2);
Insert into Card values (456,"Val'kyr Soulclaimer","Rare","Minion",3,1,4,"After this minion survives damage summon a 2/2 Ghoul.",3);
Insert into Card values (457,"Vicious Fledgling","Rare","Minion",3,3,3,"After this minion attacks a hero Adapt.",2);
Insert into Card values (458,"Void Terror","Rare","Minion",3,3,3,"Battlecry: Destroy both adjacent minions and gain their Attack and Health.",1);
Insert into Card values (459,"Ancient Watcher","Rare","Minion",2,4,5,"Can't attack.",1);
Insert into Card values (460,"Armorsmith","Rare","Minion",2,1,4,"Whenever a friendly minion takes damage gain 1 Armor.",1);
Insert into Card values (461,"Cornered Sentry","Rare","Minion",2,2,6,"Taunt. Battlecry: Summon three 1/1 Raptors for your opponent.",2);
Insert into Card values (462,"Crazed Alchemist","Rare","Minion",2,2,2,"Battlecry: Swap the Attack and Health of a minion.",1);
Insert into Card values (463,"Druid of the Swarm","Rare","Minion",2,1,2,"Choose One - Transform into a 1/2 with Poisonous or a 1/5 with Taunt.",3);
Insert into Card values (464,"Fire Plume Harbinger","Rare","Minion",2,1,1,"Battlecry: Reduce the Cost of Elementals in your hand by (1).",2);
Insert into Card values (465,"Golakka Crawler","Rare","Minion",2,2,3,"Battlecry: Destroy a Pirate and gain +1/+1.",2);
Insert into Card values (466,"Ice Walker","Rare","Minion",2,1,3,"Your Hero Power also Freezes the target.",3);
Insert into Card values (467,"Knife Juggler","Rare","Minion",2,2,2,"After you summon a minion deal 1 damage to a random enemy.",1);
Insert into Card values (468,"Lightwell","Rare","Minion",2,0,5,"At the start of your turn restore 3 Health to a damaged friendly character.",1);
Insert into Card values (469,"Mana Addict","Rare","Minion",2,1,3,"Whenever you cast a spell gain +2 Attack this turn.",1);
Insert into Card values (470,"Mana Wraith","Rare","Minion",2,2,2,"ALL minions cost (1) more.",1);
Insert into Card values (471,"Master Swordsmith","Rare","Minion",2,1,3,"At the end of your turn give another random friendly minion +1 Attack.",1);
Insert into Card values (472,"Murkspark Eel","Rare","Minion",2,2,3,"Battlecry: If your deck has only even-Cost cards deal 2 damage.",5);
Insert into Card values (473,"Murmuring Elemental","Rare","Minion",2,1,1,"Battlecry: Your next Battlecry this turn triggers twice.",4);
Insert into Card values (474,"Pint-Sized Summoner","Rare","Minion",2,2,2,"The first minion you play each turn costs (1) less.",1);
Insert into Card values (475,"Primalfin Totem","Rare","Minion",2,0,3,"At the end of your turn summon a 1/1 Murloc.",2);
Insert into Card values (476,"Redband Wasp","Rare","Minion",2,1,3,"Rush. Has +3 Attack while damaged.",5);
Insert into Card values (477,"Scorp-o-matic","Rare","Minion",2,1,2,"Battlecry: Destroy a minion with 1 or less Attack.",4);
Insert into Card values (478,"Sunfury Protector","Rare","Minion",2,2,3,"Battlecry: Give adjacent minions Taunt.",1);
Insert into Card values (479,"Wild Pyromancer","Rare","Minion",2,3,2,"After you cast a spell deal 1 damage to ALL minions.",1);
Insert into Card values (480,"Angry Chicken","Rare","Minion",1,1,1,"Enrage: +5 Attack.",1);
Insert into Card values (481,"Bloodsail Corsair","Rare","Minion",1,1,2,"Battlecry: Remove 1 Durability from your opponent's weapon.",1);
Insert into Card values (482,"Crystalline Oracle","Rare","Minion",1,1,1,"Deathrattle: Copy a card from your opponent's deck and add it to your hand.",2);
Insert into Card values (483,"Feral Gibberer","Rare","Minion",1,1,1,"After this minion attacks a hero add a copy of it to your hand.",4);
Insert into Card values (484,"Gravelsnout Knight","Rare","Minion",1,2,3,"Battlecry: Summon a random 1-Cost minion for your opponent.",4);
Insert into Card values (485,"Lightwarden","Rare","Minion",1,1,2,"Whenever a character is healed gain +2 Attack.",1);
Insert into Card values (486,"Murloc Tidecaller","Rare","Minion",1,1,2,"Whenever you summon a Murloc gain +1 Attack.",1);
Insert into Card values (487,"Raptor Hatchling","Rare","Minion",1,2,1,"Deathrattle: Shuffle a 4/3 Raptor into your deck.",2);
Insert into Card values (488,"Secretkeeper","Rare","Minion",1,1,2,"Whenever a Secret is played gain +1/+1.",1);
Insert into Card values (489,"Young Priestess","Rare","Minion",1,2,1,"At the end of your turn give another random friendly minion +1 Health.",1);
Insert into Card values (490,"Blood Razor","Common","Weapon",4,2,2,"Battlecry and Deathrattle: Deal 1 damage to all minions.",3);
Insert into Card values (491,"Stormforged Axe","Common","Weapon",2,2,3,"Overload: (1)",1);
Insert into Card values (492,"Woodcutter's Axe","Common","Weapon",2,2,2,"Deathrattle: Give +2/+1 to a random friendly Rush minion.",5);
Insert into Card values (493,"Candleshot","Common","Weapon",1,1,3,"Your hero is Immune while attacking.",4);
Insert into Card values (494,"Unidentified Shield","Common","Ability",6,0,0,"Gain 5 Armor. Gains a bonus effect in your hand.",4);
Insert into Card values (495,"Webweave","Common","Ability",5,0,0,"Summon two 1/2 Poisonous Spiders.",3);
Insert into Card values (496,"Cone of Cold","Common","Ability",4,0,0,"Freeze a minion and the minions next to it and deal 1 damage to them.",1);
Insert into Card values (497,"Dire Frenzy","Common","Ability",4,0,0,"Give a Beast +3/+3. Shuffle 3 copies into your deck with +3/+3.",5);
Insert into Card values (498,"Fiendish Circle","Common","Ability",4,0,0,"Summon four 1/1 Imps.",5);
Insert into Card values (499,"Flanking Strike","Common","Ability",4,0,0,"Deal 3 damage to a minion. Summon a 3/3 Wolf.",4);
Insert into Card values (500,"Oaken Summons","Common","Ability",4,0,0,"Gain 6 Armor. Recruit a minion that costs (4) or less.",4);
Insert into Card values (501,"Soul of the Forest","Common","Ability",4,0,0,"Give your minions Deathrattle: Summon a 2/2 Treant.",1);
Insert into Card values (502,"Tidal Surge","Common","Ability",4,0,0,"Deal 4 damage to a minion. Restore 4 Health to your hero.",2);
Insert into Card values (503,"Deadly Shot","Common","Ability",3,0,0,"Destroy a random enemy minion.",1);
Insert into Card values (504,"Ferocious Howl","Common","Ability",3,0,0,"Draw a card. Gain 1 Armor for each card in your hand.",5);
Insert into Card values (505,"Frozen Clone","Common","Ability",3,0,0,"Secret: After your opponent plays a minion add two copies of it to your hand.",3);
Insert into Card values (506,"Gnash","Common","Ability",3,0,0,"Give your hero +3 Attack this turn. Gain 3 Armor.",3);
Insert into Card values (507,"Healing Rain","Common","Ability",3,0,0,"Restore 12 Health randomly split among all friendly characters.",4);
Insert into Card values (508,"Ice Barrier","Common","Ability",3,0,0,"Secret: When your hero is attacked gain 8 Armor.",1);
Insert into Card values (509,"Mark of Nature","Common","Ability",3,0,0,"Choose One - Give a minion +4 Attack or +4 Health and Taunt.",1);
Insert into Card values (510,"Mirror Entity","Common","Ability",3,0,0,"Secret: After your opponent plays a minion summon a copy of it.",1);
Insert into Card values (511,"Sense Demons","Common","Ability",3,0,0,"Draw 2 Demons from your deck.",1);
Insert into Card values (512,"Thoughtsteal","Common","Ability",3,0,0,"Copy 2 cards in your opponent's deck and add them to your hand.",1);
Insert into Card values (513,"Unidentified Elixir","Common","Ability",3,0,0,"Give a minion +2/+2. Gains a bonus effect in your hand.",4);
Insert into Card values (514,"Unleash the Hounds","Common","Ability",3,0,0,"For each enemy minion summon a 1/1 Hound with Charge.",1);
Insert into Card values (515,"Battle Rage","Common","Ability",2,0,0,"Draw a card for each damaged friendly character.",1);
Insert into Card values (516,"Betrayal","Common","Ability",2,0,0,"Force an enemy minion to deal its damage to the minions next to it.",1);
Insert into Card values (517,"Cheap Shot","Common","Ability",2,0,0,"Echo. Deal 2 damage to a minion.",5);
Insert into Card values (518,"Cheat Death","Common","Ability",2,0,0,"Secret: When a friendly minion dies return it to your hand. It costs (2) less.",4);
Insert into Card values (519,"Crushing Hand","Common","Ability",2,0,0,"Deal 8 damage to a minion. Overload: (3)",4);
Insert into Card values (520,"Dark Conviction","Common","Ability",2,0,0,"Set a minion's Attack and Health to 3.",3);
Insert into Card values (521,"Demonfire","Common","Ability",2,0,0,"Deal 2 damage to a minion. If it’s a friendly Demon give it +2/+2 instead.",1);
Insert into Card values (522,"Divine Hymn","Common","Ability",2,0,0,"Restore 6 Health to all friendly characters.",5);
Insert into Card values (523,"Drain Soul","Common","Ability",2,0,0,"Lifesteal. Deal 2 damage to a minion.",3);
Insert into Card values (524,"Eviscerate","Common","Ability",2,0,0,"Deal 2 damage. Combo: Deal 4 damage instead.",1);
Insert into Card values (525,"Explosive Trap","Common","Ability",2,0,0,"Secret: When your hero is attacked deal 2 damage to all enemies.",1);
Insert into Card values (526,"Flame Geyser","Common","Ability",2,0,0,"Deal 2 damage. Add a 1/2 Elemental to your hand.",2);
Insert into Card values (527,"Forge of Souls","Common","Ability",2,0,0,"Draw 2 weapons from your deck.",3);
Insert into Card values (528,"Freezing Trap","Common","Ability",2,0,0,"Secret: When an enemy minion attacks return it to its owner's hand. It costs (2) more.",1);
Insert into Card values (529,"Grievous Bite","Common","Ability",2,0,0,"Deal 2 damage to a minion and 1 damage to adjacent ones.",2);
Insert into Card values (530,"Ice Fishing","Common","Ability",2,0,0,"Draw 2 Murlocs from your deck.",3);
Insert into Card values (531,"Leeching Poison","Common","Ability",2,0,0,"Give your weapon Lifesteal.",3);
Insert into Card values (532,"Potion of Heroism","Common","Ability",2,0,0,"Give a minion Divine Shield. Draw a card.",4);
Insert into Card values (533,"Power of the Wild","Common","Ability",2,0,0,"Choose One - Give your minions +1/+1 or Summon a 3/2 Panther.",1);
Insert into Card values (534,"Rampage","Common","Ability",2,0,0,"Give a damaged minion +3/+3.",1);
Insert into Card values (535,"Razorpetal Volley","Common","Ability",2,0,0,"Add two Razorpetals to your hand that deal 1 damage.",2);
Insert into Card values (536,"Rebuke","Common","Ability",2,0,0,"Enemy spells cost (5) more next turn.",5);
Insert into Card values (537,"Slam","Common","Ability",2,0,0,"Deal 2 damage to a minion. If it survives draw a card.",1);
Insert into Card values (538,"Snap Freeze","Common","Ability",2,0,0,"Freeze a minion. If it's already Frozen destroy it.",5);
Insert into Card values (539,"Snipe","Common","Ability",2,0,0,"Secret: After your opponent plays a minion deal 4 damage to it.",1);
Insert into Card values (540,"Sound the Bells!","Common","Ability",2,0,0,"Echo. Give a minion +1/+2.",5);
Insert into Card values (541,"Spirit Lash","Common","Ability",2,0,0,"Lifesteal. Deal 1 damage to all minions.",3);
Insert into Card values (542,"Sudden Betrayal","Common","Ability",2,0,0,"Secret: When a minion attacks your hero instead it attacks one of its neighbors.",4);
Insert into Card values (543,"Warpath","Common","Ability",2,0,0,"Echo. Deal  1 damage to all minions.",5);
Insert into Card values (544,"Witchwood Apple","Common","Ability",2,0,0,"Add three 2/2 Treants to your hand.",5);
Insert into Card values (545,"Wrath","Common","Ability",2,0,0,"Choose One - Deal 3 damage to a minion or 1 damage and draw a card.",1);
Insert into Card values (546,"Adaptation","Common","Ability",1,0,0,"Adapt a friendly minion.",2);
Insert into Card values (547,"Barkskin","Common","Ability",1,0,0,"Give a minion +3 Health. Gain 3 Armor.",4);
Insert into Card values (548,"Binding Heal","Common","Ability",1,0,0,"Restore 5 Health to a minion and your hero.",2);
Insert into Card values (549,"Blessing of Wisdom","Common","Ability",1,0,0,"Choose a minion. Whenever it attacks draw a card.",1);
Insert into Card values (550,"Breath of Sindragosa","Common","Ability",1,0,0,"Deal 2 damage to a random enemy minion and Freeze it.",3);
Insert into Card values (551,"Cold Blood","Common","Ability",1,0,0,"Give a minion +2 Attack. Combo: +4 Attack instead.",1);
Insert into Card values (552,"Dark Pact","Common","Ability",1,0,0,"Destroy a friendly minion. Restore 8 Health to your hero.",4);
Insert into Card values (553,"Earth Shock","Common","Ability",1,0,0,"Silence a minion then deal 1 damage to it.",1);
Insert into Card values (554,"Eye for an Eye","Common","Ability",1,0,0,"Secret: When your hero takes damage deal that much damage to the enemy hero.",1);
Insert into Card values (555,"Forked Lightning","Common","Ability",1,0,0,"Deal 2 damage to 2 random enemy minions. Overload: (2)",1);
Insert into Card values (556,"Hallucination","Common","Ability",1,0,0,"Discover a card from your opponent's class.",2);
Insert into Card values (557,"Inner Fire","Common","Ability",1,0,0,"Change a minion's Attack to be equal to its Health.",1);
Insert into Card values (558,"Iron Hide","Common","Ability",1,0,0,"Gain 5 Armor.",2);
Insert into Card values (559,"Lightning Bolt","Common","Ability",1,0,0,"Deal 3 damage. Overload: (1)",1);
Insert into Card values (560,"Lost in the Jungle","Common","Ability",1,0,0,"Summon two 1/1 Silver Hand Recruits.",2);
Insert into Card values (561,"Naturalize","Common","Ability",1,0,0,"Destroy a minion. Your opponent draws 2 cards.",1);
Insert into Card values (562,"Noble Sacrifice","Common","Ability",1,0,0,"Secret: When an enemy attacks summon a 2/1 Defender as the new target.",1);
Insert into Card values (563,"Play Dead","Common","Ability",1,0,0,"Trigger a friendly minion's Deathrattle.",3);
Insert into Card values (564,"Psionic Probe","Common","Ability",1,0,0,"Copy a spell in your opponent's deck and add it to your hand.",4);
Insert into Card values (565,"Redemption","Common","Ability",1,0,0,"Secret: When a friendly minion dies return it to life with 1 Health.",1);
Insert into Card values (566,"Repentance","Common","Ability",1,0,0,"Secret: After your opponent plays a minion reduce its Health to 1.",1);
Insert into Card values (567,"Circle of Healing","Common","Ability",0,0,0,"Restore 4 Health to ALL minions.",1);
Insert into Card values (568,"Inner Rage","Common","Ability",0,0,0,"Deal 1 damage to a minion and give it +2 Attack.",1);
Insert into Card values (569,"Shadowstep","Common","Ability",0,0,0,"Return a friendly minion to your hand. It costs (2) less.",1);
Insert into Card values (570,"Shifting Scroll","Common","Ability",0,0,0,"Each turn this is in your hand transform it into a random Mage spell.",4);
Insert into Card values (571,"Silence","Common","Ability",0,0,0,"Silence a minion.",1);
Insert into Card values (572,"Zap!","Common","Ability",0,0,0,"Deal 2 damage to a minion. Overload: (1)",5);
Insert into Card values (573,"Ultrasaur","Common","Minion",10,7,14," ",2);
Insert into Card values (574,"Giant Mastodon","Common","Minion",9,6,10,"Taunt",2);
Insert into Card values (575,"Sleepy Dragon","Common","Minion",9,4,12,"Taunt",4);
Insert into Card values (576,"Bonemare","Common","Minion",8,5,5,"Battlecry: Give a friendly minion +4/+4 and Taunt.",3);
Insert into Card values (577,"Cauldron Elemental","Common","Minion",8,7,7,"Your other Elementals have +2 Attack.",5);
Insert into Card values (578,"Deranged Doctor","Common","Minion",8,8,8,"Deathrattle: Restore 8 Health to your hero.",5);
Insert into Card values (579,"Violet Wurm","Common","Minion",8,7,7,"Deathrattle: Summon seven 1/1 Grubs.",4);
Insert into Card values (580,"Darkmire Moonkin","Common","Minion",7,2,8,"Spell Damage +2",5);
Insert into Card values (581,"Furious Ettin","Common","Minion",7,5,9,"Taunt",5);
Insert into Card values (582,"Sated Threshadon","Common","Minion",7,5,7,"Deathrattle: Summon three 1/1 Murlocs.",2);
Insert into Card values (583,"Silver Vanguard","Common","Minion",7,3,3,"Deathrattle: Recruit an 8-Cost minion.",4);
Insert into Card values (584,"Stormwatcher","Common","Minion",7,4,8,"Windfury",2);
Insert into Card values (585,"Tar Lord","Common","Minion",7,1,11,"Taunt. Has +4 Attack during your opponent’s turn.",2);
Insert into Card values (586,"Wyrmguard","Common","Minion",7,3,11,"Battlecry: If you're holding a Dragon gain +1 Attack and Taunt.",5);
Insert into Card values (587,"Frost Elemental","Common","Minion",6,5,5,"Battlecry: Freeze a character.",1);
Insert into Card values (588,"Gemstudded Golem","Common","Minion",6,5,9,"Taunt. Can only attack if you have 5 or more Armor.",4);
Insert into Card values (589,"Necrotic Geist","Common","Minion",6,5,3,"Whenever one of your other minions dies summon a 2/2 Ghoul.",3);
Insert into Card values (590,"Ornery Direhorn","Common","Minion",6,5,5,"Taunt. Battlecry: Adapt.",2);
Insert into Card values (591,"Priestess of Elune","Common","Minion",6,5,4,"Battlecry: Restore 4 Health to your hero.",1);
Insert into Card values (592,"Sabretooth Stalker","Common","Minion",6,8,2,"Stealth",2);
Insert into Card values (593,"Spellweaver","Common","Minion",6,4,4,"Spell Damage +2",3);
Insert into Card values (594,"Temple Enforcer","Common","Minion",6,6,6,"Battlecry: Give a friendly minion +3 Health.",1);
Insert into Card values (595,"Windfury Harpy","Common","Minion",6,4,5,"Windfury",1);
Insert into Card values (596,"Bloodworm","Common","Minion",5,4,4,"Lifesteal",3);
Insert into Card values (597,"Bone Baron","Common","Minion",5,5,5,"Deathrattle: Add two 1/1 Skeletons to your hand.",3);
Insert into Card values (598,"Clockwork Automaton","Common","Minion",5,4,4,"Double the damage and healing of your Hero Power.",5);
Insert into Card values (599,"Cobalt Scalebane","Common","Minion",5,5,5,"At the end of your turn give another random friendly minion +3 Attack.",3);
Insert into Card values (600,"Corrosive Sludge","Common","Minion",5,5,5,"Battlecry: Destroy your opponent's weapon.",4);
Insert into Card values (601,"Druid of the Claw","Common","Minion",5,4,4,"Choose One - Transform into a 4/4 with Charge or a 4/6 with Taunt.",1);
Insert into Card values (602,"Fen Creeper","Common","Minion",5,3,6,"Taunt",1);
Insert into Card values (603,"Fungalmancer","Common","Minion",5,2,2,"Battlecry: Give adjacent minions +2/+2.",4);
Insert into Card values (604,"Ghostly Charger","Common","Minion",5,3,4,"Divine Shield. Rush.",5);
Insert into Card values (605,"Green Jelly","Common","Minion",5,3,3,"At the end of your turn summon a 1/2 Ooze with Taunt.",4);
Insert into Card values (606,"Guild Recruiter","Common","Minion",5,2,4,"Battlecry: Recruit a minion that costs (4) or less.",4);
Insert into Card values (607,"Nesting Roc","Common","Minion",5,4,7,"Battlecry: If you control at least 2 other minions gain Taunt.",2);
Insert into Card values (608,"Quartz Elemental","Common","Minion",5,5,8,"Can't attack while damaged.",5);
Insert into Card values (609,"Rotten Applebaum","Common","Minion",5,4,5,"Taunt. Deathrattle: Restore 4 Health to your hero.",5);
Insert into Card values (610,"Silver Hand Knight","Common","Minion",5,4,4,"Battlecry: Summon a 2/2 Squire.",1);
Insert into Card values (611,"Skelemancer","Common","Minion",5,2,2,"Deathrattle: If it's your opponent's turn summon an 8/8 Skeleton.",3);
Insert into Card values (612,"Spiteful Smith","Common","Minion",5,4,6,"Enrage: Your weapon has +2 Attack.",1);
Insert into Card values (613,"Stranglethorn Tiger","Common","Minion",5,5,5,"Stealth",1);
Insert into Card values (614,"Sunborne Val'kyr","Common","Minion",5,5,4,"Battlecry: Give adjacent minions +2 Health.",3);
Insert into Card values (615,"Tar Lurker","Common","Minion",5,1,7,"Taunt. Has +3 Attack during your opponent's turn.",2);
Insert into Card values (616,"Trogg Gloomeater","Common","Minion",5,1,5,"Taunt. Poisonous.",4);
Insert into Card values (617,"Venomancer","Common","Minion",5,2,5,"Poisonous",3);
Insert into Card values (618,"Venture Co. Mercenary","Common","Minion",5,7,6,"Your minions cost (3) more.",1);
Insert into Card values (619,"Verdant Longneck","Common","Minion",5,5,4,"Battlecry: Adapt.",2);
Insert into Card values (620,"Vilebrood Skitterer","Common","Minion",5,1,3,"Poisonous. Rush",5);
Insert into Card values (621,"Ancient Brewmaster","Common","Minion",4,5,4,"Battlecry: Return a friendly minion from the battlefield to your hand.",1);
Insert into Card values (622,"Arathi Weaponsmith","Common","Minion",4,3,3,"Battlecry: Equip a 2/2 weapon.",1);
Insert into Card values (623,"Chillblade Champion","Common","Minion",4,3,2,"Charge. Lifesteal",3);
Insert into Card values (624,"Cult Master","Common","Minion",4,4,2,"Whenever one of your other minions dies draw a card.",1);
Insert into Card values (625,"Cursed Disciple","Common","Minion",4,5,1,"Deathrattle: Summon a 5/1 Revenant.",4);
Insert into Card values (626,"Dark Iron Dwarf","Common","Minion",4,4,4,"Battlecry: Give a minion +2 Attack this turn.",1);
Insert into Card values (627,"Dread Corsair","Common","Minion",4,3,3,"Taunt. Costs (1) less per Attack of your weapon.",1);
Insert into Card values (628,"Felsoul Inquisitor","Common","Minion",4,1,6,"Lifesteal. Taunt",5);
Insert into Card values (629,"Fire Plume Phoenix","Common","Minion",4,3,3,"Battlecry: Deal 2 damage.",2);
Insert into Card values (630,"Grave Shambler","Common","Minion",4,4,4,"Whenever your weapon is destroyed gain +1/+1.",3);
Insert into Card values (631,"Grim Necromancer","Common","Minion",4,2,4,"Battlecry: Summon two 1/1 Skeletons.",3);
Insert into Card values (632,"Hoarding Dragon","Common","Minion",4,5,6,"Deathrattle: Give your opponent two Coins.",4);
Insert into Card values (633,"Ironwood Golem","Common","Minion",4,3,6,"Taunt. Can only attack if you have 3 or more Armor.",4);
Insert into Card values (634,"Lakkari Felhound","Common","Minion",4,3,8,"Taunt. Battlecry: Discard two random cards.",2);
Insert into Card values (635,"Lightspawn","Common","Minion",4,0,5,"This minion's Attack is always equal to its Health.",1);
Insert into Card values (636,"Mogu'shan Warden","Common","Minion",4,1,7,"Taunt",1);
Insert into Card values (637,"Night Howler","Common","Minion",4,3,4,"Whenever this minion takes damage gain +2 Attack.",3);
Insert into Card values (638,"Ravenous Pterrordax","Common","Minion",4,4,4,"Battlecry: Destroy a friendly minion to Adapt twice.",2);
Insert into Card values (639,"Shroom Brewer","Common","Minion",4,4,4,"Battlecry: Restore 4 Health.",4);
Insert into Card values (640,"Silvermoon Guardian","Common","Minion",4,3,3,"Divine Shield",1);
Insert into Card values (641,"Sneaky Devil","Common","Minion",4,2,2,"Stealth. Your other minions have +1 Attack.",4);
Insert into Card values (642,"Spellbreaker","Common","Minion",4,4,3,"Battlecry: Silence a minion.",1);
Insert into Card values (643,"Stegodon","Common","Minion",4,2,6,"Taunt",2);
Insert into Card values (644,"Summoning Portal","Common","Minion",4,0,4,"Your minions cost (2) less but not less than (1).",1);
Insert into Card values (645,"Swift Messenger","Common","Minion",4,2,6,"Rush. Each turn this is in your hand swap its Attack and Health.",5);
Insert into Card values (646,"Tortollan Shellraiser","Common","Minion",4,2,6,"Taunt Deathrattle: Give a random friendly minion +1/+1.",2);
Insert into Card values (647,"Unpowered Steambot","Common","Minion",4,0,9,"Taunt",5);
Insert into Card values (648,"Vex Crow","Common","Minion",4,3,3,"Whenever you cast a spell summon a random 2-Cost minion.",5);
Insert into Card values (649,"Wicked Skeleton","Common","Minion",4,1,1,"Battlecry: Gain +1/+1 for each minion that died this turn.",3);
Insert into Card values (650,"Acolyte of Agony","Common","Minion",3,3,3,"Lifesteal",3);
Insert into Card values (651,"Acolyte of Pain","Common","Minion",3,1,3,"Whenever this minion takes damage draw a card.",1);
Insert into Card values (652,"Bearshark","Common","Minion",3,4,3,"Can't be targeted by spells or Hero Powers.",3);
Insert into Card values (653,"Benevolent Djinn","Common","Minion",3,2,4,"At the end of your turn restore 3 Health to your hero.",4);
Insert into Card values (654,"Black Cat","Common","Minion",3,3,3,"Spell Damage +1. Battlecry: If your deck has only odd-Cost cards draw a card.",5);
Insert into Card values (655,"Blackwald Pixie","Common","Minion",3,3,4,"Battlecry: Refresh your Hero Power.",5);
Insert into Card values (656,"Blink Fox","Common","Minion",3,3,3,"Battlecry: Add a random card to your hand (from your opponent's class).",5);
Insert into Card values (657,"Boisterous Bard","Common","Minion",3,3,2,"Battlecry: Give your other minions +1 Health.",4);
Insert into Card values (658,"Cave Hydra","Common","Minion",3,2,4,"Also damages the minions next to whomever this attacks.",4);
Insert into Card values (659,"Coldwraith","Common","Minion",3,3,4,"Battlecry: If an enemy is Frozen draw a card.",3);
Insert into Card values (660,"Crypt Lord","Common","Minion",3,1,6,"Taunt. After you summon a minion gain +1 Health.",3);
Insert into Card values (661,"Cutthroat Buccaneer","Common","Minion",3,2,4,"Combo: Give your weapon +1 Attack.",5);
Insert into Card values (662,"Deathspeaker","Common","Minion",3,2,4,"Battlecry: Give a friendly minion Immune this turn.",3);
Insert into Card values (663,"Dragonslayer","Common","Minion",3,4,3,"Battlecry: Deal 6 damage to a Dragon.",4);
Insert into Card values (664,"Drakkari Defender","Common","Minion",3,2,8,"Taunt. Overload: (3)",3);
Insert into Card values (665,"Druid of the Scythe","Common","Minion",3,2,2,"Choose One - Transform into a 4/2 with Rush or a 2/4 with Taunt.",5);
Insert into Card values (666,"Duskbat","Common","Minion",3,2,4,"Battlecry: If your hero took damage this turn summon two 1/1 Bats.",5);
Insert into Card values (667,"Earthen Ring Farseer","Common","Minion",3,3,3,"Battlecry: Restore 3 Health.",1);
Insert into Card values (668,"Eggnapper","Common","Minion",3,3,1,"Deathrattle: Summon two 1/1 Raptors.",2);
Insert into Card values (669,"Elder Longneck","Common","Minion",3,5,1,"Battlecry: If you're holding a minion with 5 or more Attack Adapt.",2);
Insert into Card values (670,"Flesheating Ghoul","Common","Minion",3,2,3,"Whenever a minion dies gain +1 Attack.",1);
Insert into Card values (671,"Fungal Enchanter","Common","Minion",3,3,3,"Battlecry: Restore 2 Health to all friendly characters.",4);
Insert into Card values (672,"Giant Wasp","Common","Minion",3,2,2,"Stealth. Poisonous",2);
Insert into Card values (673,"Gilded Gargoyle","Common","Minion",3,2,2,"Deathrattle: Add a Coin to your hand.",4);
Insert into Card values (674,"Harvest Golem","Common","Minion",3,2,3,"Deathrattle: Summon a 2/1 Damaged Golem.",1);
Insert into Card values (675,"Hench-Clan Thug","Common","Minion",3,3,3,"After your hero attacks give this minion +1/+1.",5);
Insert into Card values (676,"Hot Spring Guardian","Common","Minion",3,2,4,"Taunt. Battlecry: Restore 3 Health.",2);
Insert into Card values (677,"Howlfiend","Common","Minion",3,3,6,"Whenever this minion takes damage discard a random card.",3);
Insert into Card values (678,"Hyldnir Frostrider","Common","Minion",3,4,4,"Battlecry: Freeze your other minions.",3);
Insert into Card values (679,"Igneous Elemental","Common","Minion",3,2,3,"Deathrattle: Add two 1/2 Elementals to your hand.",2);
Insert into Card values (680,"Ironbeak Owl","Common","Minion",3,2,1,"Battlecry: Silence a minion.",1);
Insert into Card values (681,"Jungle Panther","Common","Minion",3,4,2,"Stealth",1);
Insert into Card values (682,"Kobold Apprentice","Common","Minion",3,2,1,"Battlecry: Deal 3 damage randomly split among all enemies.",4);
Insert into Card values (683,"Marsh Drake","Common","Minion",3,5,4,"Battlecry: Summon a 2/1 Poisonous Drakeslayer for your opponent.",5);
Insert into Card values (684,"Plague Scientist","Common","Minion",3,2,3,"Combo: Give a friendly minion Poisonous.",3);
Insert into Card values (685,"Primalfin Lookout","Common","Minion",3,3,2,"Battlecry: If you control another Murloc Discover a Murloc.",2);
Insert into Card values (686,"Pterrordax Hatchling","Common","Minion",3,2,2,"Battlecry: Adapt.",2);
Insert into Card values (687,"Pumpkin Peasant","Common","Minion",3,2,4,"Lifesteal. Each turn this is in your hand swap its Attack and Health.",5);
Insert into Card values (688,"Rabid Worgen","Common","Minion",3,3,3,"Rush",5);
Insert into Card values (689,"Raging Worgen","Common","Minion",3,3,3,"Enrage: Windfury and +1 Attack.",1);
Insert into Card values (690,"Ravencaller","Common","Minion",3,2,1,"Battlecry: Add two random 1-Cost minions to your hand.",5);
Insert into Card values (691,"Scarlet Crusader","Common","Minion",3,3,1,"Divine Shield",1);
Insert into Card values (692,"Sewer Crawler","Common","Minion",3,1,1,"Battlecry: Summon a 2/3 Giant Rat.",4);
Insert into Card values (693,"Stitched Tracker","Common","Minion",3,2,2,"Battlecry: Discover a copy of a minion in your deck.",3);
Insert into Card values (694,"Stoneskin Basilisk","Common","Minion",3,1,1,"Divine Shield. Poisonous",4);
Insert into Card values (695,"Tanglefur Mystic","Common","Minion",3,3,4,"Battlecry: Add a random 2-Cost minion to each player's hand.",5);
Insert into Card values (696,"Tar Creeper","Common","Minion",3,1,5,"Taunt. Has +2 Attack during your opponent's turn.",2);
Insert into Card values (697,"Tauren Warrior","Common","Minion",3,2,3,"Taunt. Enrage: +3 Attack.",1);
Insert into Card values (698,"Thrallmar Farseer","Common","Minion",3,2,3,"Windfury",1);
Insert into Card values (699,"Thunder Lizard","Common","Minion",3,3,3,"Battlecry: If you played an Elemental last turn Adapt.",2);
Insert into Card values (700,"Toothy Chest","Common","Minion",3,0,4,"At the start of your turn set this minion's Attack to 4.",4);
Insert into Card values (701,"Unbound Elemental","Common","Minion",3,2,4,"Whenever you play a card with Overload gain +1/+1.",1);
Insert into Card values (702,"Vryghoul","Common","Minion",3,3,1,"Deathrattle: If it's your opponent's turn summon a 2/2 Ghoul.",3);
Insert into Card values (703,"Walnut Sprite","Common","Minion",3,3,3,"Echo",5);
Insert into Card values (704,"Amani Berserker","Common","Minion",2,2,3,"Enrage: +3 Attack",1);
Insert into Card values (705,"Arcanologist","Common","Minion",2,2,3,"Battlecry: Draw a Secret from your deck.",2);
Insert into Card values (706,"Argent Protector","Common","Minion",2,2,2,"Battlecry: Give a friendly minion Divine Shield.",1);
Insert into Card values (707,"Bloodsail Raider","Common","Minion",2,2,3,"Battlecry: Gain Attack equal to the Attack of your weapon.",1);
Insert into Card values (708,"Brrrloc","Common","Minion",2,2,2,"Battlecry: Freeze an enemy.",3);
Insert into Card values (709,"Cavern Shinyfinder","Common","Minion",2,3,1,"Battlecry: Draw a weapon from your deck.",4);
Insert into Card values (710,"Crackling Razormaw","Common","Minion",2,3,2,"Battlecry: Adapt a friendly Beast.",2);
Insert into Card values (711,"Cruel Taskmaster","Common","Minion",2,2,2,"Battlecry: Deal 1 damage to a minion and give it +2 Attack.",1);
Insert into Card values (712,"Defias Ringleader","Common","Minion",2,2,2,"Combo: Summon a 2/1 Defias Bandit.",1);
Insert into Card values (713,"Dire Wolf Alpha","Common","Minion",2,2,2,"Adjacent minions have +1 Attack.",1);
Insert into Card values (714,"Drygulch Jailor","Common","Minion",2,1,1,"Deathrattle: Add 3 Silver Hand Recruits to your hand.",4);
Insert into Card values (715,"Drywhisker Armorer","Common","Minion",2,2,2,"Battlecry: For each enemy minion gain 2 Armor.",4);
Insert into Card values (716,"Faerie Dragon","Common","Minion",2,3,2,"Can't be targeted by spells or Hero Powers.",1);
Insert into Card values (717,"Fallen Sun Cleric","Common","Minion",2,2,1,"Battlecry: Give a friendly minion +1/+1.",3);
Insert into Card values (718,"Ghost Light Angler","Common","Minion",2,2,2,"Echo",5);
Insert into Card values (719,"Hunting Mastiff","Common","Minion",2,2,1,"Echo. Rush",5);
Insert into Card values (720,"Hydrologist","Common","Minion",2,2,2,"Battlecry: Discover a Secret.",2);
Insert into Card values (721,"Kobold Hermit","Common","Minion",2,1,1,"Battlecry: Choose a basic Totem. Summon it.",4);
Insert into Card values (722,"Loot Hoarder","Common","Minion",2,2,1,"Deathrattle: Draw a card.",1);
Insert into Card values (723,"Lost Spirit","Common","Minion",2,1,1,"Deathrattle: Give your minions +1 Attack.",5);
Insert into Card values (724,"Mad Bomber","Common","Minion",2,3,2,"Battlecry: Deal 3 damage randomly split between all other characters.",1);
Insert into Card values (725,"Plated Beetle","Common","Minion",2,2,3,"Deathrattle: Gain 3 Armor.",4);
Insert into Card values (726,"Radiant Elemental","Common","Minion",2,2,3,"Your spells cost (1) less.",2);
Insert into Card values (727,"Ravasaur Runt","Common","Minion",2,2,2,"Battlecry: If you control at least 2 other minions Adapt.",2);
Insert into Card values (728,"Raven Familiar","Common","Minion",2,2,2,"Battlecry: Reveal a spell in each deck. If yours costs more draw it.",4);
Insert into Card values (729,"Razorpetal Lasher","Common","Minion",2,2,2,"Battlecry: Add a Razorpetal to your hand that deals 1 damage.",2);
Insert into Card values (730,"Rockpool Hunter","Common","Minion",2,2,3,"Battlecry: Give a friendly Murloc +1/+1.",2);
Insert into Card values (731,"Scavenging Hyena","Common","Minion",2,2,2,"Whenever a friendly Beast dies gain +2/+1.",1);
Insert into Card values (732,"Shadow Ascendant","Common","Minion",2,2,2,"At the end of your turn give another random friendly minion +1/+1.",3);
Insert into Card values (733,"Shimmering Tempest","Common","Minion",2,2,1,"Deathrattle: Add a random Mage spell to your hand.",2);
Insert into Card values (734,"Sorcerer's Apprentice","Common","Minion",2,3,2,"Your spells cost (1) less.",1);
Insert into Card values (735,"Spellshifter","Common","Minion",2,1,4,"Spell Damage +1. Each turn this is in your hand swap its Attack and Health.",5);
Insert into Card values (736,"Squashling","Common","Minion",2,2,1,"Echo. Battlecry: Restore 2 Health.",5);
Insert into Card values (737,"Stubborn Gastropod","Common","Minion",2,1,2,"Taunt. Poisonous",2);
Insert into Card values (738,"Tainted Zealot","Common","Minion",2,1,1,"Divine Shield. Spell Damage +1",3);
Insert into Card values (739,"Tortollan Forager","Common","Minion",2,2,2,"Battlecry: Add a random minion with 5 or more Attack to your hand.",2);
Insert into Card values (740,"Tuskarr Fisherman","Common","Minion",2,2,3,"Battlecry: Give a friendly minion Spell Damage +1.",3);
Insert into Card values (741,"Vicious Scalehide","Common","Minion",2,1,3,"Lifesteal. Rush",5);
Insert into Card values (742,"Volatile Elemental","Common","Minion",2,1,1,"Deathrattle: Deal 3 damage to a random enemy minion.",2);
Insert into Card values (743,"Vulgar Homunculus","Common","Minion",2,2,4,"Taunt. Battlecry: Deal 2 damage to your hero.",4);
Insert into Card values (744,"Youthful Brewmaster","Common","Minion",2,3,2,"Battlecry: Return a friendly minion from the battlefield to your hand.",1);
Insert into Card values (745,"Abusive Sergeant","Common","Minion",1,1,1,"Battlecry: Give a minion +2 Attack this turn.",1);
Insert into Card values (746,"Acherus Veteran","Common","Minion",1,2,1,"Battlecry: Give a friendly minion +1 Attack.",3);
Insert into Card values (747,"Air Elemental","Common","Minion",1,2,1,"Can't be targeted by spells or Hero Powers.",2);
Insert into Card values (748,"Animated Berserker","Common","Minion",1,1,3,"After you play a minion deal 1 damage to it.",3);
Insert into Card values (749,"Arcane Artificer","Common","Minion",1,1,2,"Whenever you cast a spell gain Armor equal to its Cost.",4);
Insert into Card values (750,"Argent Squire","Common","Minion",1,1,1,"Divine Shield",1);
Insert into Card values (751,"Blood Imp","Common","Minion",1,0,1,"Stealth. At the end of your  turn give another randomv riendly minion +1 Health.",1);
Insert into Card values (752,"Deadscale Knight","Common","Minion",1,1,1,"Lifesteal",3);
Insert into Card values (753,"Dire Mole","Common","Minion",1,1,3," ",4);
Insert into Card values (754,"Dust Devil","Common","Minion",1,3,1,"Windfury. Overload: (2)",1);
Insert into Card values (755,"Emerald Reaver","Common","Minion",1,2,1,"Battlecry: Deal 1 damage to each hero.",2);
Insert into Card values (756,"Fire Fly","Common","Minion",1,1,2,"Battlecry: Add a 1/2 Elemental to your hand.",2);
Insert into Card values (757,"Flame Imp","Common","Minion",1,3,2,"Battlecry: Deal 3 damage to your hero.",1);
Insert into Card values (758,"Glacial Shard","Common","Minion",1,2,1,"Battlecry: Freeze an enemy.",2);
Insert into Card values (759,"Jeweled Macaw","Common","Minion",1,1,1,"Battlecry: Add a random Beast to your hand.",2);
Insert into Card values (760,"Kobold Librarian","Common","Minion",1,2,1,"Battlecry: Draw a card. Deal 2 damage to your hero.",4);
Insert into Card values (761,"Leper Gnome","Common","Minion",1,1,1,"Deathrattle: Deal 2 damage to the enemy hero.",1);
Insert into Card values (762,"Mana Wyrm","Common","Minion",1,1,3,"Whenever you cast a spell gain +1 Attack.",1);
Insert into Card values (763,"Righteous Protector","Common","Minion",1,1,1,"Taunt. Divine Shield",3);
Insert into Card values (764,"Sanguine Reveler","Common","Minion",1,1,1,"Battlecry: Destroy a friendly minion and gain +2/+2.",3);
Insert into Card values (765,"Shieldbearer","Common","Minion",1,0,4,"Taunt",1);
Insert into Card values (766,"Southsea Deckhand","Common","Minion",1,2,1,"Has Charge while you have a weapon equipped.",1);
Insert into Card values (767,"Swamp Dragon Egg","Common","Minion",1,0,3,"Deathrattle: Add a random Dragon to your hand.",5);
Insert into Card values (768,"Swamp Leech","Common","Minion",1,2,1,"Lifesteal",5);
Insert into Card values (769,"Wax Elemental","Common","Minion",1,0,2,"Taunt. Divine Shield",4);
Insert into Card values (770,"Witch's Apprentice","Common","Minion",1,0,1,"Taunt. Battlecry: Add a random Shaman spell to your hand.",5);
Insert into Card values (771,"Witchwood Imp","Common","Minion",1,1,1,"Stealth. Deathrattle: Give a random friendly minion +2 Health.",5);
Insert into Card values (772,"Worgen Infiltrator","Common","Minion",1,2,1,"Stealth",1);
Insert into Card values (773,"Wretched Tiller","Common","Minion",1,1,1,"Whenever this minion attacks deal 2 damage to the enemy hero.",3);
Insert into Card values (774,"Young Dragonhawk","Common","Minion",1,1,1,"Windfury",1);
Insert into Card values (775,"Snowflipper Penguin","Common","Minion",0,1,1," ",3);
Insert into Card values (776,"Wisp","Common","Minion",0,1,1," ",1);
Insert into Card values (777,"Arcanite Reaper","Free","Weapon",5,5,2," ",1);
Insert into Card values (778,"Assassin's Blade","Free","Weapon",5,3,4," ",1);
Insert into Card values (779,"Truesilver Champion","Free","Weapon",4,4,2,"Whenever your hero attacks restore 2 Health to it.",1);
Insert into Card values (780,"Fiery War Axe","Free","Weapon",3,3,2," ",1);
Insert into Card values (781,"Light's Justice","Free","Weapon",1,1,4," ",1);
Insert into Card values (782,"Mind Control","Free","Ability",10,0,0,"Take control of an enemy minion.",1);
Insert into Card values (783,"Flamestrike","Free","Ability",7,0,0,"Deal 4 damage to all enemy minions.",1);
Insert into Card values (784,"Sprint","Free","Ability",7,0,0,"Draw 4 cards.",1);
Insert into Card values (785,"Starfire","Free","Ability",6,0,0,"Deal 5 damage. Draw a card.",1);
Insert into Card values (786,"Vanish","Free","Ability",6,0,0,"Return all minions to their owner's hand.",1);
Insert into Card values (787,"Assassinate","Free","Ability",5,0,0,"Destroy an enemy minion.",1);
Insert into Card values (788,"Bloodlust","Free","Ability",5,0,0,"Give your minions +3 Attack this turn.",1);
Insert into Card values (789,"Holy Nova","Free","Ability",5,0,0,"Deal 2 damage to all enemies. Restore 2 Health to all friendly characters.",1);
Insert into Card values (790,"Blessing of Kings","Free","Ability",4,0,0,"Give a minion +4/+4. (+4 Attack/+4 Health)",1);
Insert into Card values (791,"Consecration","Free","Ability",4,0,0,"Deal 2 damage to all enemies.",1);
Insert into Card values (792,"Fireball","Free","Ability",4,0,0,"Deal 6 damage.",1);
Insert into Card values (793,"Hammer of Wrath","Free","Ability",4,0,0,"Deal 3 damage. Draw a card.",1);
Insert into Card values (794,"Hellfire","Free","Ability",4,0,0,"Deal 3 damage to ALL characters.",1);
Insert into Card values (795,"Hex","Free","Ability",4,0,0,"Transform a minion into a 0/1 Frog with Taunt.",1);
Insert into Card values (796,"Multi-Shot","Free","Ability",4,0,0,"Deal 3 damage to two random enemy minions.",1);
Insert into Card values (797,"Polymorph","Free","Ability",4,0,0,"Transform a minion into a 1/1 Sheep.",1);
Insert into Card values (798,"Swipe","Free","Ability",4,0,0,"Deal 4 damage to an enemy and 1 damage to all other enemies.",1);
Insert into Card values (799,"Animal Companion","Free","Ability",3,0,0,"Summon a random Beast Companion.",1);
Insert into Card values (800,"Arcane Intellect","Free","Ability",3,0,0,"Draw 2 cards.",1);
Insert into Card values (801,"Drain Life","Free","Ability",3,0,0,"Deal 2 damage. Restore 2 Health to your hero.",1);
Insert into Card values (802,"Fan of Knives","Free","Ability",3,0,0,"Deal 1 damage to all enemy minions. Draw a card.",1);
Insert into Card values (803,"Frost Nova","Free","Ability",3,0,0,"Freeze all enemy minions.",1);
Insert into Card values (804,"Healing Touch","Free","Ability",3,0,0,"Restore 8 Health.",1);
Insert into Card values (805,"Kill Command","Free","Ability",3,0,0,"Deal 3 damage. If you control a Beast deal 5 damage instead.",1);
Insert into Card values (806,"Savage Roar","Free","Ability",3,0,0,"Give your characters +2 Attack this turn.",1);
Insert into Card values (807,"Shadow Bolt","Free","Ability",3,0,0,"Deal 4 damage to a minion.",1);
Insert into Card values (808,"Shadow Word: Death","Free","Ability",3,0,0,"Destroy a minion with 5 or more Attack.",1);
Insert into Card values (809,"Shield Block","Free","Ability",3,0,0,"Gain 5 Armor. Draw a card.",1);
Insert into Card values (810,"Arcane Explosion","Free","Ability",2,0,0,"Deal 1 damage to all enemy minions.",1);
Insert into Card values (811,"Cleave","Free","Ability",2,0,0,"Deal 2 damage to two random enemy",1);
Insert into Card values (812,"Divine Spirit","Free","Ability",2,0,0,"Double a minion's Health.",1);
Insert into Card values (813,"Execute","Free","Ability",2,0,0,"Destroy a damaged enemy minion.",1);
Insert into Card values (814,"Frostbolt","Free","Ability",2,0,0,"Deal 3 damage to a character and Freeze it.",1);
Insert into Card values (815,"Heroic Strike","Free","Ability",2,0,0,"Give your hero +4 Attack this turn.",1);
Insert into Card values (816,"Holy Light","Free","Ability",2,0,0,"Restore 6 Health.",1);
Insert into Card values (817,"Mark of the Wild","Free","Ability",2,0,0,"Give a minion Taunt and +2/+2. (+2 Attack/+2 Health)",1);
Insert into Card values (818,"Mind Blast","Free","Ability",2,0,0,"Deal 5 damage to the enemy hero.",1);
Insert into Card values (819,"Rockbiter Weapon","Free","Ability",2,0,0,"Give a friendly character +3 Attack this turn.",1);
Insert into Card values (820,"Sap","Free","Ability",2,0,0,"Return an enemy minion to your opponent's hand.",1);
Insert into Card values (821,"Shadow Word: Pain","Free","Ability",2,0,0,"Destroy a minion with 3 or less Attack.",1);
Insert into Card values (822,"Shiv","Free","Ability",2,0,0,"Deal 1 damage. Draw a card.",1);
Insert into Card values (823,"Wild Growth","Free","Ability",2,0,0,"Gain an empty Mana Crystal.",1);
Insert into Card values (824,"Windfury","Free","Ability",2,0,0,"Give a minion Windfury.",1);
Insert into Card values (825,"Arcane Missiles","Free","Ability",1,0,0,"Deal 3 damage randomly split among all enemies.",1);
Insert into Card values (826,"Arcane Shot","Free","Ability",1,0,0,"Deal 2 damage.",1);
Insert into Card values (827,"Blessing of Might","Free","Ability",1,0,0,"Give a minion +3 Attack.",1);
Insert into Card values (828,"Charge","Free","Ability",1,0,0,"Give a friendly minion Charge. It can't attack heroes this turn.",1);
Insert into Card values (829,"Claw","Free","Ability",1,0,0,"Give your hero +2 Attack this turn. Gain 2 Armor.",1);
Insert into Card values (830,"Corruption","Free","Ability",1,0,0,"Choose an enemy minion. At the start of your turn destroy it.",1);
Insert into Card values (831,"Deadly Poison","Free","Ability",1,0,0,"Give your weapon +2 Attack.",1);
Insert into Card values (832,"Frost Shock","Free","Ability",1,0,0,"Deal 1 damage to an enemy character and Freeze it.",1);
Insert into Card values (833,"Hand of Protection","Free","Ability",1,0,0,"Give a minion Divine Shield.",1);
Insert into Card values (834,"Holy Smite","Free","Ability",1,0,0,"Deal 2 damage.",1);
Insert into Card values (835,"Humility","Free","Ability",1,0,0,"Change a minion's Attack to 1.",1);
Insert into Card values (836,"Hunter's Mark","Free","Ability",1,0,0,"Change a minion's Health to 1.",1);
Insert into Card values (837,"Mind Vision","Free","Ability",1,0,0,"Put a copy of a random card in your opponent's hand into your hand.",1);
Insert into Card values (838,"Mirror Image","Free","Ability",1,0,0,"Summon two 0/2 minions with Taunt.",1);
Insert into Card values (839,"Mortal Coil","Free","Ability",1,0,0,"Deal 1 damage to a minion. If that kills it draw a card.",1);
Insert into Card values (840,"Power Word: Shield","Free","Ability",1,0,0,"Give a minion +2 Health. Draw a card.",1);
Insert into Card values (841,"Sinister Strike","Free","Ability",1,0,0,"Deal 3 damage to the enemy hero.",1);
Insert into Card values (842,"Soulfire","Free","Ability",1,0,0,"Deal 4 damage. Discard a random card.",1);
Insert into Card values (843,"Tracking","Free","Ability",1,0,0,"Look at the top 3 cards of your deck. Draw one and discard the others.",1);
Insert into Card values (844,"Whirlwind","Free","Ability",1,0,0,"Deal 1 damage to ALL minions.",1);
Insert into Card values (845,"Ancestral Healing","Free","Ability",0,0,0,"Restore a minion to full Health and give it Taunt.",1);
Insert into Card values (846,"Backstab","Free","Ability",0,0,0,"Deal 2 damage to an undamaged minion.",1);
Insert into Card values (847,"Innervate","Free","Ability",0,0,0,"Gain 1 Mana Crystal this turn only.",1);
Insert into Card values (848,"Moonfire","Free","Ability",0,0,0,"Deal 1 damage.",1);
Insert into Card values (849,"Sacrificial Pact","Free","Ability",0,0,0,"Destroy a Demon. Restore 5 Health to your hero.",1);
Insert into Card values (850,"Totemic Might","Free","Ability",0,0,0,"Give your Totems +2 Health.",1);
Insert into Card values (851,"Ironbark Protector","Free","Minion",8,8,8,"Taunt",1);
Insert into Card values (852,"Core Hound","Free","Minion",7,9,5," ",1);
Insert into Card values (853,"Guardian of Kings","Free","Minion",7,5,6,"Battlecry: Restore 6 Health to your hero.",1);
Insert into Card values (854,"Stormwind Champion","Free","Minion",7,6,6,"Your other minions have +1/+1.",1);
Insert into Card values (855,"War Golem","Free","Minion",7,7,7," ",1);
Insert into Card values (856,"Archmage","Free","Minion",6,4,7,"Spell Damage +1",1);
Insert into Card values (857,"Boulderfist Ogre","Free","Minion",6,6,7," ",1);
Insert into Card values (858,"Dread Infernal","Free","Minion",6,6,6,"Battlecry: Deal 1 damage to ALL other characters.",1);
Insert into Card values (859,"Fire Elemental","Free","Minion",6,6,5,"Battlecry: Deal 3 damage.",1);
Insert into Card values (860,"Lord of the Arena","Free","Minion",6,6,5,"Taunt",1);
Insert into Card values (861,"Reckless Rocketeer","Free","Minion",6,5,2,"Charge",1);
Insert into Card values (862,"Booty Bay Bodyguard","Free","Minion",5,5,4,"Taunt",1);
Insert into Card values (863,"Darkscale Healer","Free","Minion",5,4,5,"Battlecry: Restore 2 Health to all friendly characters.",1);
Insert into Card values (864,"Frostwolf Warlord","Free","Minion",5,4,4,"Battlecry: Gain +1/+1 for each other friendly minion on the battlefield.",1);
Insert into Card values (865,"Gurubashi Berserker","Free","Minion",5,2,7,"Whenever this minion takes damage gain +3 Attack.",1);
Insert into Card values (866,"Nightblade","Free","Minion",5,4,4,"Battlecry: Deal 3 damage to the enemy hero.",1);
Insert into Card values (867,"Starving Buzzard","Free","Minion",5,3,2,"Whenever you summon a Beast draw a card.",1);
Insert into Card values (868,"Stormpike Commando","Free","Minion",5,4,2,"Battlecry: Deal 2 damage.",1);
Insert into Card values (869,"Tundra Rhino","Free","Minion",5,2,5,"Your Beasts have Charge.",1);
Insert into Card values (870,"Chillwind Yeti","Free","Minion",4,4,5," ",1);
Insert into Card values (871,"Dragonling Mechanic","Free","Minion",4,2,4,"Battlecry: Summon a 2/1 Mechanical Dragonling.",1);
Insert into Card values (872,"Gnomish Inventor","Free","Minion",4,2,4,"Battlecry: Draw a card.",1);
Insert into Card values (873,"Houndmaster","Free","Minion",4,4,3,"Battlecry: Give a friendly Beast +2/+2 and Taunt.",1);
Insert into Card values (874,"Kor'kron Elite","Free","Minion",4,4,3,"Charge",1);
Insert into Card values (875,"Oasis Snapjaw","Free","Minion",4,2,7," ",1);
Insert into Card values (876,"Ogre Magi","Free","Minion",4,4,4,"Spell Damage +1",1);
Insert into Card values (877,"Sen'jin Shieldmasta","Free","Minion",4,3,5,"Taunt",1);
Insert into Card values (878,"Stormwind Knight","Free","Minion",4,2,5,"Charge",1);
Insert into Card values (879,"Water Elemental","Free","Minion",4,3,6,"Freeze any character damaged by this minion.",1);
Insert into Card values (880,"Windspeaker","Free","Minion",4,3,3,"Battlecry: Give a friendly minion Windfury.",1);
Insert into Card values (881,"Dalaran Mage","Free","Minion",3,1,4,"Spell Damage +1",1);
Insert into Card values (882,"Ironforge Rifleman","Free","Minion",3,2,2,"Battlecry: Deal 1 damage.",1);
Insert into Card values (883,"Ironfur Grizzly","Free","Minion",3,3,3,"Taunt",1);
Insert into Card values (884,"Magma Rager","Free","Minion",3,5,1," ",1);
Insert into Card values (885,"Raid Leader","Free","Minion",3,2,2,"Your other minions have +1 Attack.",1);
Insert into Card values (886,"Razorfen Hunter","Free","Minion",3,2,3,"Battlecry: Summon a 1/1 Boar.",1);
Insert into Card values (887,"Shattered Sun Cleric","Free","Minion",3,3,2,"Battlecry: Give a friendly minion +1/+1.",1);
Insert into Card values (888,"Silverback Patriarch","Free","Minion",3,1,4,"Taunt",1);
Insert into Card values (889,"Warsong Commander","Free","Minion",3,2,3,"Your Charge minions have +1 Attack.",1);
Insert into Card values (890,"Wolfrider","Free","Minion",3,3,1,"Charge",1);
Insert into Card values (891,"Acidic Swamp Ooze","Free","Minion",2,3,2,"Battlecry: Destroy your opponent's weapon.",1);
Insert into Card values (892,"Bloodfen Raptor","Free","Minion",2,3,2," ",1);
Insert into Card values (893,"Bluegill Warrior","Free","Minion",2,2,1,"Charge",1);
Insert into Card values (894,"Flametongue Totem","Free","Minion",2,0,3,"Adjacent minions have +2 Attack.",1);
Insert into Card values (895,"Frostwolf Grunt","Free","Minion",2,2,2,"Taunt",1);
Insert into Card values (896,"Kobold Geomancer","Free","Minion",2,2,2,"Spell Damage +1",1);
Insert into Card values (897,"Murloc Tidehunter","Free","Minion",2,2,1,"Battlecry: Summon a 1/1 Murloc Scout.",1);
Insert into Card values (898,"Novice Engineer","Free","Minion",2,1,1,"Battlecry: Draw a card.",1);
Insert into Card values (899,"River Crocolisk","Free","Minion",2,2,3," ",1);
Insert into Card values (900,"Succubus","Free","Minion",2,4,3,"Battlecry: Discard a random card.",1);
Insert into Card values (901,"Elven Archer","Free","Minion",1,1,1,"Battlecry: Deal 1 damage.",1);
Insert into Card values (902,"Goldshire Footman","Free","Minion",1,1,2,"Taunt",1);
Insert into Card values (903,"Grimscale Oracle","Free","Minion",1,1,1,"Your other Murlocs have +1 Attack.",1);
Insert into Card values (904,"Murloc Raider","Free","Minion",1,2,1," ",1);
Insert into Card values (905,"Northshire Cleric","Free","Minion",1,1,3,"Whenever a minion is healed draw a card.",1);
Insert into Card values (906,"Stonetusk Boar","Free","Minion",1,1,1,"Charge",1);
Insert into Card values (907,"Timber Wolf","Free","Minion",1,1,1,"Your other Beasts have +1 Attack.",1);
Insert into Card values (908,"Voidwalker","Free","Minion",1,1,3,"Taunt",1);
Insert into Card values (909,"Voodoo Doctor","Free","Minion",1,2,1,"Battlecry: Restore 2 Health.",1);

/* Mechanic */
Insert into Mechanic values ("Adapt","Choose one of 3 bonuses");
Insert into Mechanic values ("Battlecry","Does something when you play it from your hand");
Insert into Mechanic values ("Charge","Can attack immediately");
Insert into Mechanic values ("Choose One"," ");
Insert into Mechanic values ("Combo","A bonus if you already played a card this turn");
Insert into Mechanic values ("Deathrattle","Does something when it dies");
Insert into Mechanic values ("Discover","Choose one of three cards to add to your hand");
Insert into Mechanic values ("Divine Shield","The first time a Shielded minion take damage, ignore it");
Insert into Mechanic values ("Echo","Repetable the turn you play this");
Insert into Mechanic values ("Enrage","Does something when it is damaged");
Insert into Mechanic values ("Freeze","Frozen characters lose their next attack");
Insert into Mechanic values ("Immune","Immune characters can't be damaged");
Insert into Mechanic values ("Lifesteal","Damage dealt also heals your hero");
Insert into Mechanic values ("Overload","You have X less mana next turn");
Insert into Mechanic values ("Poisonous","Destroy any minion damaged by this");
Insert into Mechanic values ("Quest","Starts in your hand. Complete for a reward.");
Insert into Mechanic values ("Recruit","Summon a minion from your deck");
Insert into Mechanic values ("Rush","Can attack minions immediately");
Insert into Mechanic values ("Secret","Hidden until a specific action occurs on your opponet's turn");
Insert into Mechanic values ("Silence","Removes all card text and enchantments");
Insert into Mechanic values ("Spell Damage","Your spells deal extra damage");
Insert into Mechanic values ("Stealth","Can't be attacked or targeted until it attacks");
Insert into Mechanic values ("Taunt","Enemies must attack this minion");
Insert into Mechanic values ("Windfury","Can attack twice each turn");

/* Play */
Insert into Play values ("Warlock",1);
Insert into Play values ("Mage",2);
Insert into Play values ("Paladin",3);
Insert into Play values ("Rogue",4);
Insert into Play values ("Shaman",5);
Insert into Play values ("Warrior",6);
Insert into Play values ("Priest",7);
Insert into Play values ("Druid",8);
Insert into Play values ("Hunter",9);
Insert into Play values ("Shaman",10);
Insert into Play values ("Shaman",11);
Insert into Play values ("Warrior",12);
Insert into Play values ("Hunter",13);
Insert into Play values ("Mage",14);
Insert into Play values ("Paladin",15);
Insert into Play values ("Warlock",16);
Insert into Play values ("Druid",17);
Insert into Play values ("Priest",18);
Insert into Play values ("Rogue",19);
Insert into Play values ("Priest",20);
Insert into Play values ("Warrior",21);
Insert into Play values ("Druid",22);
Insert into Play values ("Warlock",23);
Insert into Play values ("Mage",24);
Insert into Play values ("Rogue",25);
Insert into Play values ("Paladin",26);
Insert into Play values ("Hunter",27);
Insert into Play values ("Shaman",28);
Insert into Play values ("Everyone",29);
Insert into Play values ("Hunter",30);
Insert into Play values ("Druid",31);
Insert into Play values ("Everyone",32);
Insert into Play values ("Everyone",33);
Insert into Play values ("Druid",34);
Insert into Play values ("Mage",35);
Insert into Play values ("Druid",36);
Insert into Play values ("Hunter",37);
Insert into Play values ("Warrior",38);
Insert into Play values ("Warlock",39);
Insert into Play values ("Everyone",40);
Insert into Play values ("Everyone",41);
Insert into Play values ("Everyone",42);
Insert into Play values ("Everyone",43);
Insert into Play values ("Everyone",44);
Insert into Play values ("Shaman",45);
Insert into Play values ("Everyone",46);
Insert into Play values ("Shaman",47);
Insert into Play values ("Warrior",48);
Insert into Play values ("Warrior",49);
Insert into Play values ("Everyone",50);
Insert into Play values ("Shaman",51);
Insert into Play values ("Hunter",52);
Insert into Play values ("Everyone",53);
Insert into Play values ("Everyone",54);
Insert into Play values ("Warrior",55);
Insert into Play values ("Mage",56);
Insert into Play values ("Druid",57);
Insert into Play values ("Rogue",58);
Insert into Play values ("Everyone",59);
Insert into Play values ("Paladin",60);
Insert into Play values ("Priest",61);
Insert into Play values ("Mage",62);
Insert into Play values ("Everyone",63);
Insert into Play values ("Everyone",64);
Insert into Play values ("Warrior",65);
Insert into Play values ("Everyone",66);
Insert into Play values ("Warlock",67);
Insert into Play values ("Paladin",68);
Insert into Play values ("Priest",69);
Insert into Play values ("Hunter",70);
Insert into Play values ("Priest",71);
Insert into Play values ("Everyone",72);
Insert into Play values ("Everyone",73);
Insert into Play values ("Warlock",74);
Insert into Play values ("Shaman",75);
Insert into Play values ("Everyone",76);
Insert into Play values ("Everyone",77);
Insert into Play values ("Everyone",78);
Insert into Play values ("Priest",79);
Insert into Play values ("Shaman",80);
Insert into Play values ("Warlock",81);
Insert into Play values ("Paladin",82);
Insert into Play values ("Everyone",83);
Insert into Play values ("Everyone",84);
Insert into Play values ("Mage",85);
Insert into Play values ("Warlock",86);
Insert into Play values ("Paladin",87);
Insert into Play values ("Everyone",88);
Insert into Play values ("Warrior",89);
Insert into Play values ("Everyone",90);
Insert into Play values ("Druid",91);
Insert into Play values ("Everyone",92);
Insert into Play values ("Everyone",93);
Insert into Play values ("Druid",94);
Insert into Play values ("Everyone",95);
Insert into Play values ("Priest",96);
Insert into Play values ("Paladin",97);
Insert into Play values ("Everyone",98);
Insert into Play values ("Hunter",99);
Insert into Play values ("Rogue",100);
Insert into Play values ("Everyone",101);
Insert into Play values ("Hunter",102);
Insert into Play values ("Rogue",103);
Insert into Play values ("Everyone",104);
Insert into Play values ("Everyone",105);
Insert into Play values ("Paladin",106);
Insert into Play values ("Everyone",107);
Insert into Play values ("Rogue",108);
Insert into Play values ("Rogue",109);
Insert into Play values ("Everyone",110);
Insert into Play values ("Everyone",111);
Insert into Play values ("Rogue",112);
Insert into Play values ("Everyone",113);
Insert into Play values ("Everyone",114);
Insert into Play values ("Mage",115);
Insert into Play values ("Everyone",116);
Insert into Play values ("Warlock",117);
Insert into Play values ("Everyone",118);
Insert into Play values ("Everyone",119);
Insert into Play values ("Everyone",120);
Insert into Play values ("Everyone",121);
Insert into Play values ("Mage",122);
Insert into Play values ("Priest",123);
Insert into Play values ("Hunter",124);
Insert into Play values ("Warrior",125);
Insert into Play values ("Shaman",126);
Insert into Play values ("Paladin",127);
Insert into Play values ("Rogue",128);
Insert into Play values ("Paladin",129);
Insert into Play values ("Warrior",130);
Insert into Play values ("Mage",131);
Insert into Play values ("Druid",132);
Insert into Play values ("Paladin",133);
Insert into Play values ("Mage",134);
Insert into Play values ("Paladin",135);
Insert into Play values ("Warlock",136);
Insert into Play values ("Hunter",137);
Insert into Play values ("Priest",138);
Insert into Play values ("Paladin",139);
Insert into Play values ("Warrior",140);
Insert into Play values ("Priest",141);
Insert into Play values ("Mage",142);
Insert into Play values ("Hunter",143);
Insert into Play values ("Warlock",144);
Insert into Play values ("Warrior",145);
Insert into Play values ("Mage",146);
Insert into Play values ("Mage",147);
Insert into Play values ("Druid",148);
Insert into Play values ("Paladin",149);
Insert into Play values ("Druid",150);
Insert into Play values ("Warrior",151);
Insert into Play values ("Druid",152);
Insert into Play values ("Paladin",153);
Insert into Play values ("Warlock",154);
Insert into Play values ("Priest",155);
Insert into Play values ("Rogue",156);
Insert into Play values ("Druid",157);
Insert into Play values ("Shaman",158);
Insert into Play values ("Warrior",159);
Insert into Play values ("Priest",160);
Insert into Play values ("Mage",161);
Insert into Play values ("Mage",162);
Insert into Play values ("Shaman",163);
Insert into Play values ("Warlock",164);
Insert into Play values ("Priest",165);
Insert into Play values ("Warlock",166);
Insert into Play values ("Mage",167);
Insert into Play values ("Warrior",168);
Insert into Play values ("Shaman",169);
Insert into Play values ("Warrior",170);
Insert into Play values ("Hunter",171);
Insert into Play values ("Rogue",172);
Insert into Play values ("Warrior",173);
Insert into Play values ("Mage",174);
Insert into Play values ("Hunter",175);
Insert into Play values ("Priest",176);
Insert into Play values ("Hunter",177);
Insert into Play values ("Hunter",178);
Insert into Play values ("Hunter",179);
Insert into Play values ("Rogue",180);
Insert into Play values ("Paladin",181);
Insert into Play values ("Warrior",182);
Insert into Play values ("Hunter",183);
Insert into Play values ("Shaman",184);
Insert into Play values ("Rogue",185);
Insert into Play values ("Everyone",186);
Insert into Play values ("Shaman",187);
Insert into Play values ("Everyone",188);
Insert into Play values ("Everyone",189);
Insert into Play values ("Priest",190);
Insert into Play values ("Warlock",191);
Insert into Play values ("Everyone",192);
Insert into Play values ("Everyone",193);
Insert into Play values ("Everyone",194);
Insert into Play values ("Everyone",195);
Insert into Play values ("Everyone",196);
Insert into Play values ("Hunter",197);
Insert into Play values ("Druid",198);
Insert into Play values ("Druid",199);
Insert into Play values ("Everyone",200);
Insert into Play values ("Shaman",201);
Insert into Play values ("Everyone",202);
Insert into Play values ("Druid",203);
Insert into Play values ("Shaman",204);
Insert into Play values ("Everyone",205);
Insert into Play values ("Paladin",206);
Insert into Play values ("Priest",207);
Insert into Play values ("Everyone",208);
Insert into Play values ("Rogue",209);
Insert into Play values ("Everyone",210);
Insert into Play values ("Everyone",211);
Insert into Play values ("Everyone",212);
Insert into Play values ("Rogue",213);
Insert into Play values ("Everyone",214);
Insert into Play values ("Everyone",215);
Insert into Play values ("Everyone",216);
Insert into Play values ("Everyone",217);
Insert into Play values ("Everyone",218);
Insert into Play values ("Warlock",219);
Insert into Play values ("Shaman",220);
Insert into Play values ("Everyone",221);
Insert into Play values ("Druid",222);
Insert into Play values ("Priest",223);
Insert into Play values ("Druid",224);
Insert into Play values ("Everyone",225);
Insert into Play values ("Everyone",226);
Insert into Play values ("Rogue",227);
Insert into Play values ("Shaman",228);
Insert into Play values ("Mage",229);
Insert into Play values ("Druid",230);
Insert into Play values ("Everyone",231);
Insert into Play values ("Everyone",232);
Insert into Play values ("Everyone",233);
Insert into Play values ("Rogue",234);
Insert into Play values ("Everyone",235);
Insert into Play values ("Everyone",236);
Insert into Play values ("Warlock",237);
Insert into Play values ("Everyone",238);
Insert into Play values ("Everyone",239);
Insert into Play values ("Everyone",240);
Insert into Play values ("Shaman",241);
Insert into Play values ("Hunter",242);
Insert into Play values ("Everyone",243);
Insert into Play values ("Warlock",244);
Insert into Play values ("Priest",245);
Insert into Play values ("Everyone",246);
Insert into Play values ("Everyone",247);
Insert into Play values ("Everyone",248);
Insert into Play values ("Everyone",249);
Insert into Play values ("Warlock",250);
Insert into Play values ("Everyone",251);
Insert into Play values ("Everyone",252);
Insert into Play values ("Priest",253);
Insert into Play values ("Everyone",254);
Insert into Play values ("Everyone",255);
Insert into Play values ("Everyone",256);
Insert into Play values ("Everyone",257);
Insert into Play values ("Rogue",258);
Insert into Play values ("Paladin",259);
Insert into Play values ("Everyone",260);
Insert into Play values ("Warlock",261);
Insert into Play values ("Rogue",262);
Insert into Play values ("Paladin",263);
Insert into Play values ("Everyone",264);
Insert into Play values ("Everyone",265);
Insert into Play values ("Warrior",266);
Insert into Play values ("Paladin",267);
Insert into Play values ("Paladin",268);
Insert into Play values ("Rogue",269);
Insert into Play values ("Hunter",270);
Insert into Play values ("Shaman",271);
Insert into Play values ("Rogue",272);
Insert into Play values ("Rogue",273);
Insert into Play values ("Paladin",274);
Insert into Play values ("Warrior",275);
Insert into Play values ("Priest",276);
Insert into Play values ("Priest",277);
Insert into Play values ("Warrior",278);
Insert into Play values ("Shaman",279);
Insert into Play values ("Mage",280);
Insert into Play values ("Warrior",281);
Insert into Play values ("Priest",282);
Insert into Play values ("Priest",283);
Insert into Play values ("Warlock",284);
Insert into Play values ("Paladin",285);
Insert into Play values ("Druid",286);
Insert into Play values ("Paladin",287);
Insert into Play values ("Priest",288);
Insert into Play values ("Hunter",289);
Insert into Play values ("Warlock",290);
Insert into Play values ("Priest",291);
Insert into Play values ("Paladin",292);
Insert into Play values ("Hunter",293);
Insert into Play values ("Rogue",294);
Insert into Play values ("Druid",295);
Insert into Play values ("Druid",296);
Insert into Play values ("Shaman",297);
Insert into Play values ("Shaman",298);
Insert into Play values ("Druid",299);
Insert into Play values ("Rogue",300);
Insert into Play values ("Priest",301);
Insert into Play values ("Druid",302);
Insert into Play values ("Warlock",303);
Insert into Play values ("Priest",304);
Insert into Play values ("Mage",305);
Insert into Play values ("Warrior",306);
Insert into Play values ("Priest",307);
Insert into Play values ("Warlock",308);
Insert into Play values ("Hunter",309);
Insert into Play values ("Mage",310);
Insert into Play values ("Mage",311);
Insert into Play values ("Paladin",312);
Insert into Play values ("Rogue",313);
Insert into Play values ("Mage",314);
Insert into Play values ("Shaman",315);
Insert into Play values ("Rogue",316);
Insert into Play values ("Shaman",317);
Insert into Play values ("Shaman",318);
Insert into Play values ("Mage",319);
Insert into Play values ("Rogue",320);
Insert into Play values ("Shaman",321);
Insert into Play values ("Priest",322);
Insert into Play values ("Warlock",323);
Insert into Play values ("Mage",324);
Insert into Play values ("Druid",325);
Insert into Play values ("Shaman",326);
Insert into Play values ("Warrior",327);
Insert into Play values ("Warlock",328);
Insert into Play values ("Warlock",329);
Insert into Play values ("Warlock",330);
Insert into Play values ("Paladin",331);
Insert into Play values ("Shaman",332);
Insert into Play values ("Paladin",333);
Insert into Play values ("Hunter",334);
Insert into Play values ("Paladin",335);
Insert into Play values ("Mage",336);
Insert into Play values ("Hunter",337);
Insert into Play values ("Rogue",338);
Insert into Play values ("Rogue",339);
Insert into Play values ("Hunter",340);
Insert into Play values ("Hunter",341);
Insert into Play values ("Shaman",342);
Insert into Play values ("Warlock",343);
Insert into Play values ("Druid",344);
Insert into Play values ("Druid",345);
Insert into Play values ("Druid",346);
Insert into Play values ("Warrior",347);
Insert into Play values ("Everyone",348);
Insert into Play values ("Druid",349);
Insert into Play values ("Priest",350);
Insert into Play values ("Everyone",351);
Insert into Play values ("Everyone",352);
Insert into Play values ("Everyone",353);
Insert into Play values ("Everyone",354);
Insert into Play values ("Priest",355);
Insert into Play values ("Warlock",356);
Insert into Play values ("Paladin",357);
Insert into Play values ("Rogue",358);
Insert into Play values ("Everyone",359);
Insert into Play values ("Everyone",360);
Insert into Play values ("Everyone",361);
Insert into Play values ("Hunter",362);
Insert into Play values ("Hunter",363);
Insert into Play values ("Everyone",364);
Insert into Play values ("Everyone",365);
Insert into Play values ("Druid",366);
Insert into Play values ("Mage",367);
Insert into Play values ("Hunter",368);
Insert into Play values ("Everyone",369);
Insert into Play values ("Everyone",370);
Insert into Play values ("Hunter",371);
Insert into Play values ("Mage",372);
Insert into Play values ("Warrior",373);
Insert into Play values ("Warlock",374);
Insert into Play values ("Warrior",375);
Insert into Play values ("Warlock",376);
Insert into Play values ("Warrior",377);
Insert into Play values ("Everyone",378);
Insert into Play values ("Warlock",379);
Insert into Play values ("Everyone",380);
Insert into Play values ("Everyone",381);
Insert into Play values ("Hunter",382);
Insert into Play values ("Shaman",383);
Insert into Play values ("Everyone",384);
Insert into Play values ("Everyone",385);
Insert into Play values ("Paladin",386);
Insert into Play values ("Priest",387);
Insert into Play values ("Paladin",388);
Insert into Play values ("Warlock",389);
Insert into Play values ("Everyone",390);
Insert into Play values ("Priest",391);
Insert into Play values ("Everyone",392);
Insert into Play values ("Rogue",393);
Insert into Play values ("Mage",394);
Insert into Play values ("Hunter",395);
Insert into Play values ("Druid",396);
Insert into Play values ("Mage",397);
Insert into Play values ("Warlock",398);
Insert into Play values ("Everyone",399);
Insert into Play values ("Druid",400);
Insert into Play values ("Rogue",401);
Insert into Play values ("Everyone",402);
Insert into Play values ("Mage",403);
Insert into Play values ("Everyone",404);
Insert into Play values ("Paladin",405);
Insert into Play values ("Everyone",406);
Insert into Play values ("Rogue",407);
Insert into Play values ("Warrior",408);
Insert into Play values ("Rogue",409);
Insert into Play values ("Everyone",410);
Insert into Play values ("Everyone",411);
Insert into Play values ("Rogue",412);
Insert into Play values ("Everyone",413);
Insert into Play values ("Everyone",414);
Insert into Play values ("Druid",415);
Insert into Play values ("Mage",416);
Insert into Play values ("Druid",417);
Insert into Play values ("Everyone",418);
Insert into Play values ("Everyone",419);
Insert into Play values ("Everyone",420);
Insert into Play values ("Everyone",421);
Insert into Play values ("Everyone",422);
Insert into Play values ("Everyone",423);
Insert into Play values ("Paladin",424);
Insert into Play values ("Everyone",425);
Insert into Play values ("Everyone",426);
Insert into Play values ("Everyone",427);
Insert into Play values ("Everyone",428);
Insert into Play values ("Mage",429);
Insert into Play values ("Hunter",430);
Insert into Play values ("Everyone",431);
Insert into Play values ("Warlock",432);
Insert into Play values ("Warrior",433);
Insert into Play values ("Druid",434);
Insert into Play values ("Everyone",435);
Insert into Play values ("Paladin",436);
Insert into Play values ("Everyone",437);
Insert into Play values ("Everyone",438);
Insert into Play values ("Everyone",439);
Insert into Play values ("Mage",440);
Insert into Play values ("Warrior",441);
Insert into Play values ("Everyone",442);
Insert into Play values ("Shaman",443);
Insert into Play values ("Everyone",444);
Insert into Play values ("Everyone",445);
Insert into Play values ("Priest",446);
Insert into Play values ("Warrior",447);
Insert into Play values ("Paladin",448);
Insert into Play values ("Everyone",449);
Insert into Play values ("Everyone",450);
Insert into Play values ("Everyone",451);
Insert into Play values ("Everyone",452);
Insert into Play values ("Rogue",453);
Insert into Play values ("Everyone",454);
Insert into Play values ("Hunter",455);
Insert into Play values ("Warrior",456);
Insert into Play values ("Everyone",457);
Insert into Play values ("Warlock",458);
Insert into Play values ("Everyone",459);
Insert into Play values ("Warrior",460);
Insert into Play values ("Warrior",461);
Insert into Play values ("Everyone",462);
Insert into Play values ("Druid",463);
Insert into Play values ("Shaman",464);
Insert into Play values ("Everyone",465);
Insert into Play values ("Mage",466);
Insert into Play values ("Everyone",467);
Insert into Play values ("Priest",468);
Insert into Play values ("Everyone",469);
Insert into Play values ("Everyone",470);
Insert into Play values ("Everyone",471);
Insert into Play values ("Shaman",472);
Insert into Play values ("Shaman",473);
Insert into Play values ("Everyone",474);
Insert into Play values ("Shaman",475);
Insert into Play values ("Warrior",476);
Insert into Play values ("Everyone",477);
Insert into Play values ("Everyone",478);
Insert into Play values ("Everyone",479);
Insert into Play values ("Everyone",480);
Insert into Play values ("Everyone",481);
Insert into Play values ("Priest",482);
Insert into Play values ("Everyone",483);
Insert into Play values ("Everyone",484);
Insert into Play values ("Everyone",485);
Insert into Play values ("Everyone",486);
Insert into Play values ("Hunter",487);
Insert into Play values ("Everyone",488);
Insert into Play values ("Everyone",489);
Insert into Play values ("Warrior",490);
Insert into Play values ("Shaman",491);
Insert into Play values ("Warrior",492);
Insert into Play values ("Hunter",493);
Insert into Play values ("Warrior",494);
Insert into Play values ("Druid",495);
Insert into Play values ("Mage",496);
Insert into Play values ("Hunter",497);
Insert into Play values ("Warlock",498);
Insert into Play values ("Hunter",499);
Insert into Play values ("Druid",500);
Insert into Play values ("Druid",501);
Insert into Play values ("Shaman",502);
Insert into Play values ("Hunter",503);
Insert into Play values ("Druid",504);
Insert into Play values ("Mage",505);
Insert into Play values ("Druid",506);
Insert into Play values ("Shaman",507);
Insert into Play values ("Mage",508);
Insert into Play values ("Druid",509);
Insert into Play values ("Mage",510);
Insert into Play values ("Warlock",511);
Insert into Play values ("Priest",512);
Insert into Play values ("Priest",513);
Insert into Play values ("Hunter",514);
Insert into Play values ("Warrior",515);
Insert into Play values ("Rogue",516);
Insert into Play values ("Rogue",517);
Insert into Play values ("Rogue",518);
Insert into Play values ("Shaman",519);
Insert into Play values ("Paladin",520);
Insert into Play values ("Warlock",521);
Insert into Play values ("Priest",522);
Insert into Play values ("Warlock",523);
Insert into Play values ("Rogue",524);
Insert into Play values ("Hunter",525);
Insert into Play values ("Mage",526);
Insert into Play values ("Warrior",527);
Insert into Play values ("Hunter",528);
Insert into Play values ("Hunter",529);
Insert into Play values ("Shaman",530);
Insert into Play values ("Rogue",531);
Insert into Play values ("Paladin",532);
Insert into Play values ("Druid",533);
Insert into Play values ("Warrior",534);
Insert into Play values ("Rogue",535);
Insert into Play values ("Paladin",536);
Insert into Play values ("Warrior",537);
Insert into Play values ("Mage",538);
Insert into Play values ("Hunter",539);
Insert into Play values ("Paladin",540);
Insert into Play values ("Priest",541);
Insert into Play values ("Rogue",542);
Insert into Play values ("Warrior",543);
Insert into Play values ("Druid",544);
Insert into Play values ("Druid",545);
Insert into Play values ("Paladin",546);
Insert into Play values ("Druid",547);
Insert into Play values ("Priest",548);
Insert into Play values ("Paladin",549);
Insert into Play values ("Mage",550);
Insert into Play values ("Rogue",551);
Insert into Play values ("Warlock",552);
Insert into Play values ("Shaman",553);
Insert into Play values ("Paladin",554);
Insert into Play values ("Shaman",555);
Insert into Play values ("Rogue",556);
Insert into Play values ("Priest",557);
Insert into Play values ("Warrior",558);
Insert into Play values ("Shaman",559);
Insert into Play values ("Paladin",560);
Insert into Play values ("Druid",561);
Insert into Play values ("Paladin",562);
Insert into Play values ("Hunter",563);
Insert into Play values ("Priest",564);
Insert into Play values ("Paladin",565);
Insert into Play values ("Paladin",566);
Insert into Play values ("Priest",567);
Insert into Play values ("Warrior",568);
Insert into Play values ("Rogue",569);
Insert into Play values ("Mage",570);
Insert into Play values ("Priest",571);
Insert into Play values ("Shaman",572);
Insert into Play values ("Everyone",573);
Insert into Play values ("Everyone",574);
Insert into Play values ("Everyone",575);
Insert into Play values ("Everyone",576);
Insert into Play values ("Everyone",577);
Insert into Play values ("Everyone",578);
Insert into Play values ("Everyone",579);
Insert into Play values ("Everyone",580);
Insert into Play values ("Everyone",581);
Insert into Play values ("Everyone",582);
Insert into Play values ("Everyone",583);
Insert into Play values ("Everyone",584);
Insert into Play values ("Warrior",585);
Insert into Play values ("Everyone",586);
Insert into Play values ("Everyone",587);
Insert into Play values ("Warrior",588);
Insert into Play values ("Everyone",589);
Insert into Play values ("Warrior",590);
Insert into Play values ("Everyone",591);
Insert into Play values ("Everyone",592);
Insert into Play values ("Everyone",593);
Insert into Play values ("Priest",594);
Insert into Play values ("Everyone",595);
Insert into Play values ("Everyone",596);
Insert into Play values ("Rogue",597);
Insert into Play values ("Everyone",598);
Insert into Play values ("Everyone",599);
Insert into Play values ("Everyone",600);
Insert into Play values ("Druid",601);
Insert into Play values ("Everyone",602);
Insert into Play values ("Everyone",603);
Insert into Play values ("Paladin",604);
Insert into Play values ("Everyone",605);
Insert into Play values ("Everyone",606);
Insert into Play values ("Everyone",607);
Insert into Play values ("Priest",608);
Insert into Play values ("Everyone",609);
Insert into Play values ("Everyone",610);
Insert into Play values ("Everyone",611);
Insert into Play values ("Everyone",612);
Insert into Play values ("Everyone",613);
Insert into Play values ("Everyone",614);
Insert into Play values ("Warlock",615);
Insert into Play values ("Everyone",616);
Insert into Play values ("Everyone",617);
Insert into Play values ("Everyone",618);
Insert into Play values ("Druid",619);
Insert into Play values ("Hunter",620);
Insert into Play values ("Everyone",621);
Insert into Play values ("Warrior",622);
Insert into Play values ("Paladin",623);
Insert into Play values ("Everyone",624);
Insert into Play values ("Everyone",625);
Insert into Play values ("Everyone",626);
Insert into Play values ("Everyone",627);
Insert into Play values ("Everyone",628);
Insert into Play values ("Everyone",629);
Insert into Play values ("Everyone",630);
Insert into Play values ("Everyone",631);
Insert into Play values ("Everyone",632);
Insert into Play values ("Druid",633);
Insert into Play values ("Warlock",634);
Insert into Play values ("Priest",635);
Insert into Play values ("Everyone",636);
Insert into Play values ("Everyone",637);
Insert into Play values ("Warlock",638);
Insert into Play values ("Everyone",639);
Insert into Play values ("Everyone",640);
Insert into Play values ("Everyone",641);
Insert into Play values ("Everyone",642);
Insert into Play values ("Everyone",643);
Insert into Play values ("Warlock",644);
Insert into Play values ("Everyone",645);
Insert into Play values ("Priest",646);
Insert into Play values ("Everyone",647);
Insert into Play values ("Mage",648);
Insert into Play values ("Everyone",649);
Insert into Play values ("Priest",650);
Insert into Play values ("Everyone",651);
Insert into Play values ("Hunter",652);
Insert into Play values ("Paladin",653);
Insert into Play values ("Mage",654);
Insert into Play values ("Everyone",655);
Insert into Play values ("Rogue",656);
Insert into Play values ("Everyone",657);
Insert into Play values ("Hunter",658);
Insert into Play values ("Mage",659);
Insert into Play values ("Druid",660);
Insert into Play values ("Rogue",661);
Insert into Play values ("Everyone",662);
Insert into Play values ("Everyone",663);
Insert into Play values ("Shaman",664);
Insert into Play values ("Druid",665);
Insert into Play values ("Warlock",666);
Insert into Play values ("Everyone",667);
Insert into Play values ("Everyone",668);
Insert into Play values ("Druid",669);
Insert into Play values ("Everyone",670);
Insert into Play values ("Everyone",671);
Insert into Play values ("Everyone",672);
Insert into Play values ("Priest",673);
Insert into Play values ("Everyone",674);
Insert into Play values ("Everyone",675);
Insert into Play values ("Shaman",676);
Insert into Play values ("Warlock",677);
Insert into Play values ("Everyone",678);
Insert into Play values ("Everyone",679);
Insert into Play values ("Everyone",680);
Insert into Play values ("Everyone",681);
Insert into Play values ("Everyone",682);
Insert into Play values ("Everyone",683);
Insert into Play values ("Rogue",684);
Insert into Play values ("Everyone",685);
Insert into Play values ("Everyone",686);
Insert into Play values ("Everyone",687);
Insert into Play values ("Warrior",688);
Insert into Play values ("Everyone",689);
Insert into Play values ("Everyone",690);
Insert into Play values ("Everyone",691);
Insert into Play values ("Everyone",692);
Insert into Play values ("Hunter",693);
Insert into Play values ("Everyone",694);
Insert into Play values ("Everyone",695);
Insert into Play values ("Everyone",696);
Insert into Play values ("Everyone",697);
Insert into Play values ("Everyone",698);
Insert into Play values ("Everyone",699);
Insert into Play values ("Everyone",700);
Insert into Play values ("Shaman",701);
Insert into Play values ("Everyone",702);
Insert into Play values ("Everyone",703);
Insert into Play values ("Everyone",704);
Insert into Play values ("Mage",705);
Insert into Play values ("Paladin",706);
Insert into Play values ("Everyone",707);
Insert into Play values ("Shaman",708);
Insert into Play values ("Rogue",709);
Insert into Play values ("Hunter",710);
Insert into Play values ("Warrior",711);
Insert into Play values ("Rogue",712);
Insert into Play values ("Everyone",713);
Insert into Play values ("Paladin",714);
Insert into Play values ("Warrior",715);
Insert into Play values ("Everyone",716);
Insert into Play values ("Everyone",717);
Insert into Play values ("Shaman",718);
Insert into Play values ("Hunter",719);
Insert into Play values ("Paladin",720);
Insert into Play values ("Shaman",721);
Insert into Play values ("Everyone",722);
Insert into Play values ("Everyone",723);
Insert into Play values ("Everyone",724);
Insert into Play values ("Everyone",725);
Insert into Play values ("Priest",726);
Insert into Play values ("Everyone",727);
Insert into Play values ("Mage",728);
Insert into Play values ("Rogue",729);
Insert into Play values ("Everyone",730);
Insert into Play values ("Hunter",731);
Insert into Play values ("Priest",732);
Insert into Play values ("Mage",733);
Insert into Play values ("Mage",734);
Insert into Play values ("Everyone",735);
Insert into Play values ("Priest",736);
Insert into Play values ("Everyone",737);
Insert into Play values ("Everyone",738);
Insert into Play values ("Druid",739);
Insert into Play values ("Everyone",740);
Insert into Play values ("Everyone",741);
Insert into Play values ("Everyone",742);
Insert into Play values ("Warlock",743);
Insert into Play values ("Everyone",744);
Insert into Play values ("Everyone",745);
Insert into Play values ("Everyone",746);
Insert into Play values ("Shaman",747);
Insert into Play values ("Warrior",748);
Insert into Play values ("Mage",749);
Insert into Play values ("Everyone",750);
Insert into Play values ("Warlock",751);
Insert into Play values ("Everyone",752);
Insert into Play values ("Everyone",753);
Insert into Play values ("Shaman",754);
Insert into Play values ("Everyone",755);
Insert into Play values ("Everyone",756);
Insert into Play values ("Warlock",757);
Insert into Play values ("Everyone",758);
Insert into Play values ("Hunter",759);
Insert into Play values ("Warlock",760);
Insert into Play values ("Everyone",761);
Insert into Play values ("Mage",762);
Insert into Play values ("Paladin",763);
Insert into Play values ("Warlock",764);
Insert into Play values ("Everyone",765);
Insert into Play values ("Everyone",766);
Insert into Play values ("Everyone",767);
Insert into Play values ("Everyone",768);
Insert into Play values ("Everyone",769);
Insert into Play values ("Shaman",770);
Insert into Play values ("Warlock",771);
Insert into Play values ("Everyone",772);
Insert into Play values ("Everyone",773);
Insert into Play values ("Everyone",774);
Insert into Play values ("Everyone",775);
Insert into Play values ("Everyone",776);
Insert into Play values ("Warrior",777);
Insert into Play values ("Rogue",778);
Insert into Play values ("Paladin",779);
Insert into Play values ("Warrior",780);
Insert into Play values ("Paladin",781);
Insert into Play values ("Priest",782);
Insert into Play values ("Mage",783);
Insert into Play values ("Rogue",784);
Insert into Play values ("Druid",785);
Insert into Play values ("Rogue",786);
Insert into Play values ("Rogue",787);
Insert into Play values ("Shaman",788);
Insert into Play values ("Priest",789);
Insert into Play values ("Paladin",790);
Insert into Play values ("Paladin",791);
Insert into Play values ("Mage",792);
Insert into Play values ("Paladin",793);
Insert into Play values ("Warlock",794);
Insert into Play values ("Shaman",795);
Insert into Play values ("Hunter",796);
Insert into Play values ("Mage",797);
Insert into Play values ("Druid",798);
Insert into Play values ("Hunter",799);
Insert into Play values ("Mage",800);
Insert into Play values ("Warlock",801);
Insert into Play values ("Rogue",802);
Insert into Play values ("Mage",803);
Insert into Play values ("Druid",804);
Insert into Play values ("Hunter",805);
Insert into Play values ("Druid",806);
Insert into Play values ("Warlock",807);
Insert into Play values ("Priest",808);
Insert into Play values ("Warrior",809);
Insert into Play values ("Mage",810);
Insert into Play values ("Warrior",811);
Insert into Play values ("Priest",812);
Insert into Play values ("Warrior",813);
Insert into Play values ("Mage",814);
Insert into Play values ("Warrior",815);
Insert into Play values ("Paladin",816);
Insert into Play values ("Druid",817);
Insert into Play values ("Priest",818);
Insert into Play values ("Shaman",819);
Insert into Play values ("Rogue",820);
Insert into Play values ("Priest",821);
Insert into Play values ("Rogue",822);
Insert into Play values ("Druid",823);
Insert into Play values ("Shaman",824);
Insert into Play values ("Mage",825);
Insert into Play values ("Hunter",826);
Insert into Play values ("Paladin",827);
Insert into Play values ("Warrior",828);
Insert into Play values ("Druid",829);
Insert into Play values ("Warlock",830);
Insert into Play values ("Rogue",831);
Insert into Play values ("Shaman",832);
Insert into Play values ("Paladin",833);
Insert into Play values ("Priest",834);
Insert into Play values ("Paladin",835);
Insert into Play values ("Hunter",836);
Insert into Play values ("Priest",837);
Insert into Play values ("Mage",838);
Insert into Play values ("Warlock",839);
Insert into Play values ("Priest",840);
Insert into Play values ("Rogue",841);
Insert into Play values ("Warlock",842);
Insert into Play values ("Hunter",843);
Insert into Play values ("Warrior",844);
Insert into Play values ("Shaman",845);
Insert into Play values ("Rogue",846);
Insert into Play values ("Druid",847);
Insert into Play values ("Druid",848);
Insert into Play values ("Warlock",849);
Insert into Play values ("Shaman",850);
Insert into Play values ("Druid",851);
Insert into Play values ("Everyone",852);
Insert into Play values ("Paladin",853);
Insert into Play values ("Everyone",854);
Insert into Play values ("Everyone",855);
Insert into Play values ("Everyone",856);
Insert into Play values ("Everyone",857);
Insert into Play values ("Warlock",858);
Insert into Play values ("Shaman",859);
Insert into Play values ("Everyone",860);
Insert into Play values ("Everyone",861);
Insert into Play values ("Everyone",862);
Insert into Play values ("Everyone",863);
Insert into Play values ("Everyone",864);
Insert into Play values ("Everyone",865);
Insert into Play values ("Everyone",866);
Insert into Play values ("Hunter",867);
Insert into Play values ("Everyone",868);
Insert into Play values ("Hunter",869);
Insert into Play values ("Everyone",870);
Insert into Play values ("Everyone",871);
Insert into Play values ("Everyone",872);
Insert into Play values ("Hunter",873);
Insert into Play values ("Warrior",874);
Insert into Play values ("Everyone",875);
Insert into Play values ("Everyone",876);
Insert into Play values ("Everyone",877);
Insert into Play values ("Everyone",878);
Insert into Play values ("Mage",879);
Insert into Play values ("Shaman",880);
Insert into Play values ("Everyone",881);
Insert into Play values ("Everyone",882);
Insert into Play values ("Everyone",883);
Insert into Play values ("Everyone",884);
Insert into Play values ("Everyone",885);
Insert into Play values ("Everyone",886);
Insert into Play values ("Everyone",887);
Insert into Play values ("Everyone",888);
Insert into Play values ("Warrior",889);
Insert into Play values ("Everyone",890);
Insert into Play values ("Everyone",891);
Insert into Play values ("Everyone",892);
Insert into Play values ("Everyone",893);
Insert into Play values ("Shaman",894);
Insert into Play values ("Everyone",895);
Insert into Play values ("Everyone",896);
Insert into Play values ("Everyone",897);
Insert into Play values ("Everyone",898);
Insert into Play values ("Everyone",899);
Insert into Play values ("Warlock",900);
Insert into Play values ("Everyone",901);
Insert into Play values ("Everyone",902);
Insert into Play values ("Everyone",903);
Insert into Play values ("Everyone",904);
Insert into Play values ("Priest",905);
Insert into Play values ("Everyone",906);
Insert into Play values ("Hunter",907);
Insert into Play values ("Warlock",908);
Insert into Play values ("Everyone",909);

/* Have */
Insert into Have values (235,"Adapt");
Insert into Have values (302,"Adapt");
Insert into Have values (352,"Adapt");
Insert into Have values (405,"Adapt");
Insert into Have values (457,"Adapt");
Insert into Have values (546,"Adapt");
Insert into Have values (590,"Adapt");
Insert into Have values (619,"Adapt");
Insert into Have values (638,"Adapt");
Insert into Have values (669,"Adapt");
Insert into Have values (686,"Adapt");
Insert into Have values (699,"Adapt");
Insert into Have values (710,"Adapt");
Insert into Have values (727,"Adapt");
Insert into Have values (1,"Battlecry");
Insert into Have values (2,"Battlecry");
Insert into Have values (3,"Battlecry");
Insert into Have values (4,"Battlecry");
Insert into Have values (5,"Battlecry");
Insert into Have values (6,"Battlecry");
Insert into Have values (7,"Battlecry");
Insert into Have values (9,"Battlecry");
Insert into Have values (10,"Battlecry");
Insert into Have values (13,"Battlecry");
Insert into Have values (29,"Battlecry");
Insert into Have values (30,"Battlecry");
Insert into Have values (32,"Battlecry");
Insert into Have values (35,"Battlecry");
Insert into Have values (38,"Battlecry");
Insert into Have values (39,"Battlecry");
Insert into Have values (41,"Battlecry");
Insert into Have values (43,"Battlecry");
Insert into Have values (44,"Battlecry");
Insert into Have values (45,"Battlecry");
Insert into Have values (51,"Battlecry");
Insert into Have values (52,"Battlecry");
Insert into Have values (53,"Battlecry");
Insert into Have values (54,"Battlecry");
Insert into Have values (56,"Battlecry");
Insert into Have values (57,"Battlecry");
Insert into Have values (58,"Battlecry");
Insert into Have values (61,"Battlecry");
Insert into Have values (63,"Battlecry");
Insert into Have values (66,"Battlecry");
Insert into Have values (67,"Battlecry");
Insert into Have values (68,"Battlecry");
Insert into Have values (71,"Battlecry");
Insert into Have values (75,"Battlecry");
Insert into Have values (76,"Battlecry");
Insert into Have values (79,"Battlecry");
Insert into Have values (82,"Battlecry");
Insert into Have values (84,"Battlecry");
Insert into Have values (85,"Battlecry");
Insert into Have values (88,"Battlecry");
Insert into Have values (92,"Battlecry");
Insert into Have values (93,"Battlecry");
Insert into Have values (95,"Battlecry");
Insert into Have values (97,"Battlecry");
Insert into Have values (100,"Battlecry");
Insert into Have values (101,"Battlecry");
Insert into Have values (105,"Battlecry");
Insert into Have values (109,"Battlecry");
Insert into Have values (110,"Battlecry");
Insert into Have values (111,"Battlecry");
Insert into Have values (113,"Battlecry");
Insert into Have values (114,"Battlecry");
Insert into Have values (119,"Battlecry");
Insert into Have values (121,"Battlecry");
Insert into Have values (192,"Battlecry");
Insert into Have values (194,"Battlecry");
Insert into Have values (196,"Battlecry");
Insert into Have values (200,"Battlecry");
Insert into Have values (204,"Battlecry");
Insert into Have values (207,"Battlecry");
Insert into Have values (208,"Battlecry");
Insert into Have values (210,"Battlecry");
Insert into Have values (212,"Battlecry");
Insert into Have values (214,"Battlecry");
Insert into Have values (216,"Battlecry");
Insert into Have values (218,"Battlecry");
Insert into Have values (219,"Battlecry");
Insert into Have values (221,"Battlecry");
Insert into Have values (223,"Battlecry");
Insert into Have values (224,"Battlecry");
Insert into Have values (225,"Battlecry");
Insert into Have values (226,"Battlecry");
Insert into Have values (228,"Battlecry");
Insert into Have values (229,"Battlecry");
Insert into Have values (231,"Battlecry");
Insert into Have values (232,"Battlecry");
Insert into Have values (233,"Battlecry");
Insert into Have values (234,"Battlecry");
Insert into Have values (235,"Battlecry");
Insert into Have values (237,"Battlecry");
Insert into Have values (238,"Battlecry");
Insert into Have values (239,"Battlecry");
Insert into Have values (241,"Battlecry");
Insert into Have values (243,"Battlecry");
Insert into Have values (244,"Battlecry");
Insert into Have values (245,"Battlecry");
Insert into Have values (247,"Battlecry");
Insert into Have values (250,"Battlecry");
Insert into Have values (251,"Battlecry");
Insert into Have values (253,"Battlecry");
Insert into Have values (254,"Battlecry");
Insert into Have values (255,"Battlecry");
Insert into Have values (257,"Battlecry");
Insert into Have values (259,"Battlecry");
Insert into Have values (261,"Battlecry");
Insert into Have values (265,"Battlecry");
Insert into Have values (266,"Battlecry");
Insert into Have values (272,"Battlecry");
Insert into Have values (273,"Battlecry");
Insert into Have values (342,"Battlecry");
Insert into Have values (352,"Battlecry");
Insert into Have values (361,"Battlecry");
Insert into Have values (363,"Battlecry");
Insert into Have values (366,"Battlecry");
Insert into Have values (367,"Battlecry");
Insert into Have values (368,"Battlecry");
Insert into Have values (369,"Battlecry");
Insert into Have values (370,"Battlecry");
Insert into Have values (373,"Battlecry");
Insert into Have values (376,"Battlecry");
Insert into Have values (378,"Battlecry");
Insert into Have values (380,"Battlecry");
Insert into Have values (381,"Battlecry");
Insert into Have values (382,"Battlecry");
Insert into Have values (384,"Battlecry");
Insert into Have values (385,"Battlecry");
Insert into Have values (388,"Battlecry");
Insert into Have values (390,"Battlecry");
Insert into Have values (391,"Battlecry");
Insert into Have values (392,"Battlecry");
Insert into Have values (397,"Battlecry");
Insert into Have values (398,"Battlecry");
Insert into Have values (403,"Battlecry");
Insert into Have values (404,"Battlecry");
Insert into Have values (405,"Battlecry");
Insert into Have values (406,"Battlecry");
Insert into Have values (407,"Battlecry");
Insert into Have values (408,"Battlecry");
Insert into Have values (410,"Battlecry");
Insert into Have values (411,"Battlecry");
Insert into Have values (413,"Battlecry");
Insert into Have values (414,"Battlecry");
Insert into Have values (416,"Battlecry");
Insert into Have values (417,"Battlecry");
Insert into Have values (419,"Battlecry");
Insert into Have values (420,"Battlecry");
Insert into Have values (422,"Battlecry");
Insert into Have values (424,"Battlecry");
Insert into Have values (425,"Battlecry");
Insert into Have values (426,"Battlecry");
Insert into Have values (432,"Battlecry");
Insert into Have values (436,"Battlecry");
Insert into Have values (439,"Battlecry");
Insert into Have values (440,"Battlecry");
Insert into Have values (442,"Battlecry");
Insert into Have values (444,"Battlecry");
Insert into Have values (446,"Battlecry");
Insert into Have values (454,"Battlecry");
Insert into Have values (455,"Battlecry");
Insert into Have values (458,"Battlecry");
Insert into Have values (461,"Battlecry");
Insert into Have values (462,"Battlecry");
Insert into Have values (464,"Battlecry");
Insert into Have values (465,"Battlecry");
Insert into Have values (472,"Battlecry");
Insert into Have values (473,"Battlecry");
Insert into Have values (477,"Battlecry");
Insert into Have values (478,"Battlecry");
Insert into Have values (481,"Battlecry");
Insert into Have values (484,"Battlecry");
Insert into Have values (490,"Battlecry");
Insert into Have values (576,"Battlecry");
Insert into Have values (586,"Battlecry");
Insert into Have values (587,"Battlecry");
Insert into Have values (590,"Battlecry");
Insert into Have values (591,"Battlecry");
Insert into Have values (594,"Battlecry");
Insert into Have values (600,"Battlecry");
Insert into Have values (603,"Battlecry");
Insert into Have values (606,"Battlecry");
Insert into Have values (607,"Battlecry");
Insert into Have values (610,"Battlecry");
Insert into Have values (614,"Battlecry");
Insert into Have values (619,"Battlecry");
Insert into Have values (621,"Battlecry");
Insert into Have values (622,"Battlecry");
Insert into Have values (626,"Battlecry");
Insert into Have values (629,"Battlecry");
Insert into Have values (631,"Battlecry");
Insert into Have values (634,"Battlecry");
Insert into Have values (638,"Battlecry");
Insert into Have values (639,"Battlecry");
Insert into Have values (642,"Battlecry");
Insert into Have values (649,"Battlecry");
Insert into Have values (654,"Battlecry");
Insert into Have values (655,"Battlecry");
Insert into Have values (656,"Battlecry");
Insert into Have values (657,"Battlecry");
Insert into Have values (659,"Battlecry");
Insert into Have values (662,"Battlecry");
Insert into Have values (663,"Battlecry");
Insert into Have values (666,"Battlecry");
Insert into Have values (667,"Battlecry");
Insert into Have values (669,"Battlecry");
Insert into Have values (671,"Battlecry");
Insert into Have values (676,"Battlecry");
Insert into Have values (678,"Battlecry");
Insert into Have values (680,"Battlecry");
Insert into Have values (682,"Battlecry");
Insert into Have values (683,"Battlecry");
Insert into Have values (685,"Battlecry");
Insert into Have values (686,"Battlecry");
Insert into Have values (690,"Battlecry");
Insert into Have values (692,"Battlecry");
Insert into Have values (693,"Battlecry");
Insert into Have values (695,"Battlecry");
Insert into Have values (699,"Battlecry");
Insert into Have values (705,"Battlecry");
Insert into Have values (706,"Battlecry");
Insert into Have values (707,"Battlecry");
Insert into Have values (708,"Battlecry");
Insert into Have values (709,"Battlecry");
Insert into Have values (710,"Battlecry");
Insert into Have values (711,"Battlecry");
Insert into Have values (715,"Battlecry");
Insert into Have values (717,"Battlecry");
Insert into Have values (720,"Battlecry");
Insert into Have values (721,"Battlecry");
Insert into Have values (724,"Battlecry");
Insert into Have values (727,"Battlecry");
Insert into Have values (728,"Battlecry");
Insert into Have values (729,"Battlecry");
Insert into Have values (730,"Battlecry");
Insert into Have values (736,"Battlecry");
Insert into Have values (739,"Battlecry");
Insert into Have values (740,"Battlecry");
Insert into Have values (743,"Battlecry");
Insert into Have values (744,"Battlecry");
Insert into Have values (745,"Battlecry");
Insert into Have values (746,"Battlecry");
Insert into Have values (755,"Battlecry");
Insert into Have values (756,"Battlecry");
Insert into Have values (757,"Battlecry");
Insert into Have values (758,"Battlecry");
Insert into Have values (759,"Battlecry");
Insert into Have values (760,"Battlecry");
Insert into Have values (764,"Battlecry");
Insert into Have values (770,"Battlecry");
Insert into Have values (853,"Battlecry");
Insert into Have values (858,"Battlecry");
Insert into Have values (859,"Battlecry");
Insert into Have values (863,"Battlecry");
Insert into Have values (864,"Battlecry");
Insert into Have values (866,"Battlecry");
Insert into Have values (868,"Battlecry");
Insert into Have values (871,"Battlecry");
Insert into Have values (872,"Battlecry");
Insert into Have values (873,"Battlecry");
Insert into Have values (880,"Battlecry");
Insert into Have values (882,"Battlecry");
Insert into Have values (886,"Battlecry");
Insert into Have values (887,"Battlecry");
Insert into Have values (891,"Battlecry");
Insert into Have values (897,"Battlecry");
Insert into Have values (898,"Battlecry");
Insert into Have values (900,"Battlecry");
Insert into Have values (901,"Battlecry");
Insert into Have values (909,"Battlecry");
Insert into Have values (37,"Charge");
Insert into Have values (47,"Charge");
Insert into Have values (49,"Charge");
Insert into Have values (95,"Charge");
Insert into Have values (192,"Charge");
Insert into Have values (353,"Charge");
Insert into Have values (376,"Charge");
Insert into Have values (514,"Charge");
Insert into Have values (601,"Charge");
Insert into Have values (623,"Charge");
Insert into Have values (766,"Charge");
Insert into Have values (828,"Charge");
Insert into Have values (861,"Charge");
Insert into Have values (869,"Charge");
Insert into Have values (874,"Charge");
Insert into Have values (878,"Charge");
Insert into Have values (889,"Charge");
Insert into Have values (890,"Charge");
Insert into Have values (893,"Charge");
Insert into Have values (906,"Charge");
Insert into Have values (8,"Choose One");
Insert into Have values (34,"Choose One");
Insert into Have values (198,"Choose One");
Insert into Have values (199,"Choose One");
Insert into Have values (295,"Choose One");
Insert into Have values (296,"Choose One");
Insert into Have values (400,"Choose One");
Insert into Have values (415,"Choose One");
Insert into Have values (463,"Choose One");
Insert into Have values (509,"Choose One");
Insert into Have values (533,"Choose One");
Insert into Have values (545,"Choose One");
Insert into Have values (601,"Choose One");
Insert into Have values (665,"Choose One");
Insert into Have values (108,"Combo");
Insert into Have values (209,"Combo");
Insert into Have values (213,"Combo");
Insert into Have values (227,"Combo");
Insert into Have values (258,"Combo");
Insert into Have values (272,"Combo");
Insert into Have values (316,"Combo");
Insert into Have values (358,"Combo");
Insert into Have values (393,"Combo");
Insert into Have values (453,"Combo");
Insert into Have values (524,"Combo");
Insert into Have values (551,"Combo");
Insert into Have values (661,"Combo");
Insert into Have values (684,"Combo");
Insert into Have values (712,"Combo");
Insert into Have values (15,"Deathrattle");
Insert into Have values (17,"Deathrattle");
Insert into Have values (19,"Deathrattle");
Insert into Have values (20,"Deathrattle");
Insert into Have values (36,"Deathrattle");
Insert into Have values (52,"Deathrattle");
Insert into Have values (60,"Deathrattle");
Insert into Have values (66,"Deathrattle");
Insert into Have values (72,"Deathrattle");
Insert into Have values (81,"Deathrattle");
Insert into Have values (83,"Deathrattle");
Insert into Have values (98,"Deathrattle");
Insert into Have values (103,"Deathrattle");
Insert into Have values (104,"Deathrattle");
Insert into Have values (116,"Deathrattle");
Insert into Have values (122,"Deathrattle");
Insert into Have values (163,"Deathrattle");
Insert into Have values (190,"Deathrattle");
Insert into Have values (191,"Deathrattle");
Insert into Have values (195,"Deathrattle");
Insert into Have values (197,"Deathrattle");
Insert into Have values (203,"Deathrattle");
Insert into Have values (218,"Deathrattle");
Insert into Have values (222,"Deathrattle");
Insert into Have values (226,"Deathrattle");
Insert into Have values (230,"Deathrattle");
Insert into Have values (236,"Deathrattle");
Insert into Have values (238,"Deathrattle");
Insert into Have values (255,"Deathrattle");
Insert into Have values (263,"Deathrattle");
Insert into Have values (294,"Deathrattle");
Insert into Have values (321,"Deathrattle");
Insert into Have values (322,"Deathrattle");
Insert into Have values (326,"Deathrattle");
Insert into Have values (331,"Deathrattle");
Insert into Have values (339,"Deathrattle");
Insert into Have values (349,"Deathrattle");
Insert into Have values (354,"Deathrattle");
Insert into Have values (355,"Deathrattle");
Insert into Have values (356,"Deathrattle");
Insert into Have values (358,"Deathrattle");
Insert into Have values (362,"Deathrattle");
Insert into Have values (363,"Deathrattle");
Insert into Have values (365,"Deathrattle");
Insert into Have values (370,"Deathrattle");
Insert into Have values (371,"Deathrattle");
Insert into Have values (375,"Deathrattle");
Insert into Have values (379,"Deathrattle");
Insert into Have values (386,"Deathrattle");
Insert into Have values (388,"Deathrattle");
Insert into Have values (395,"Deathrattle");
Insert into Have values (401,"Deathrattle");
Insert into Have values (418,"Deathrattle");
Insert into Have values (428,"Deathrattle");
Insert into Have values (434,"Deathrattle");
Insert into Have values (447,"Deathrattle");
Insert into Have values (451,"Deathrattle");
Insert into Have values (455,"Deathrattle");
Insert into Have values (482,"Deathrattle");
Insert into Have values (487,"Deathrattle");
Insert into Have values (490,"Deathrattle");
Insert into Have values (492,"Deathrattle");
Insert into Have values (501,"Deathrattle");
Insert into Have values (563,"Deathrattle");
Insert into Have values (578,"Deathrattle");
Insert into Have values (579,"Deathrattle");
Insert into Have values (582,"Deathrattle");
Insert into Have values (583,"Deathrattle");
Insert into Have values (597,"Deathrattle");
Insert into Have values (609,"Deathrattle");
Insert into Have values (611,"Deathrattle");
Insert into Have values (625,"Deathrattle");
Insert into Have values (632,"Deathrattle");
Insert into Have values (646,"Deathrattle");
Insert into Have values (668,"Deathrattle");
Insert into Have values (673,"Deathrattle");
Insert into Have values (674,"Deathrattle");
Insert into Have values (679,"Deathrattle");
Insert into Have values (702,"Deathrattle");
Insert into Have values (714,"Deathrattle");
Insert into Have values (722,"Deathrattle");
Insert into Have values (723,"Deathrattle");
Insert into Have values (725,"Deathrattle");
Insert into Have values (733,"Deathrattle");
Insert into Have values (742,"Deathrattle");
Insert into Have values (761,"Deathrattle");
Insert into Have values (767,"Deathrattle");
Insert into Have values (771,"Deathrattle");
Insert into Have values (11,"Discover");
Insert into Have values (173,"Discover");
Insert into Have values (174,"Discover");
Insert into Have values (176,"Discover");
Insert into Have values (196,"Discover");
Insert into Have values (229,"Discover");
Insert into Have values (244,"Discover");
Insert into Have values (276,"Discover");
Insert into Have values (301,"Discover");
Insert into Have values (342,"Discover");
Insert into Have values (343,"Discover");
Insert into Have values (380,"Discover");
Insert into Have values (454,"Discover");
Insert into Have values (556,"Discover");
Insert into Have values (685,"Discover");
Insert into Have values (693,"Discover");
Insert into Have values (720,"Discover");
Insert into Have values (47,"Divine Shield");
Insert into Have values (60,"Divine Shield");
Insert into Have values (87,"Divine Shield");
Insert into Have values (106,"Divine Shield");
Insert into Have values (127,"Divine Shield");
Insert into Have values (232,"Divine Shield");
Insert into Have values (243,"Divine Shield");
Insert into Have values (259,"Divine Shield");
Insert into Have values (348,"Divine Shield");
Insert into Have values (353,"Divine Shield");
Insert into Have values (357,"Divine Shield");
Insert into Have values (364,"Divine Shield");
Insert into Have values (419,"Divine Shield");
Insert into Have values (436,"Divine Shield");
Insert into Have values (442,"Divine Shield");
Insert into Have values (532,"Divine Shield");
Insert into Have values (604,"Divine Shield");
Insert into Have values (640,"Divine Shield");
Insert into Have values (691,"Divine Shield");
Insert into Have values (694,"Divine Shield");
Insert into Have values (706,"Divine Shield");
Insert into Have values (738,"Divine Shield");
Insert into Have values (750,"Divine Shield");
Insert into Have values (763,"Divine Shield");
Insert into Have values (769,"Divine Shield");
Insert into Have values (833,"Divine Shield");
Insert into Have values (74,"Echo");
Insert into Have values (109,"Echo");
Insert into Have values (329,"Echo");
Insert into Have values (338,"Echo");
Insert into Have values (409,"Echo");
Insert into Have values (449,"Echo");
Insert into Have values (517,"Echo");
Insert into Have values (540,"Echo");
Insert into Have values (543,"Echo");
Insert into Have values (703,"Echo");
Insert into Have values (718,"Echo");
Insert into Have values (719,"Echo");
Insert into Have values (736,"Echo");
Insert into Have values (49,"Enrage");
Insert into Have values (480,"Enrage");
Insert into Have values (612,"Enrage");
Insert into Have values (689,"Enrage");
Insert into Have values (697,"Enrage");
Insert into Have values (704,"Enrage");
Insert into Have values (169,"Freeze");
Insert into Have values (280,"Freeze");
Insert into Have values (298,"Freeze");
Insert into Have values (359,"Freeze");
Insert into Have values (383,"Freeze");
Insert into Have values (466,"Freeze");
Insert into Have values (496,"Freeze");
Insert into Have values (538,"Freeze");
Insert into Have values (550,"Freeze");
Insert into Have values (587,"Freeze");
Insert into Have values (678,"Freeze");
Insert into Have values (708,"Freeze");
Insert into Have values (758,"Freeze");
Insert into Have values (803,"Freeze");
Insert into Have values (814,"Freeze");
Insert into Have values (832,"Freeze");
Insert into Have values (879,"Freeze");
Insert into Have values (124,"Immune");
Insert into Have values (172,"Immune");
Insert into Have values (179,"Immune");
Insert into Have values (273,"Immune");
Insert into Have values (493,"Immune");
Insert into Have values (662,"Immune");
Insert into Have values (2,"Lifesteal");
Insert into Have values (3,"Lifesteal");
Insert into Have values (66,"Lifesteal");
Insert into Have values (86,"Lifesteal");
Insert into Have values (101,"Lifesteal");
Insert into Have values (128,"Lifesteal");
Insert into Have values (190,"Lifesteal");
Insert into Have values (219,"Lifesteal");
Insert into Have values (232,"Lifesteal");
Insert into Have values (233,"Lifesteal");
Insert into Have values (303,"Lifesteal");
Insert into Have values (448,"Lifesteal");
Insert into Have values (523,"Lifesteal");
Insert into Have values (531,"Lifesteal");
Insert into Have values (541,"Lifesteal");
Insert into Have values (596,"Lifesteal");
Insert into Have values (623,"Lifesteal");
Insert into Have values (628,"Lifesteal");
Insert into Have values (650,"Lifesteal");
Insert into Have values (687,"Lifesteal");
Insert into Have values (741,"Lifesteal");
Insert into Have values (752,"Lifesteal");
Insert into Have values (768,"Lifesteal");
Insert into Have values (126,"Overload");
Insert into Have values (187,"Overload");
Insert into Have values (220,"Overload");
Insert into Have values (279,"Overload");
Insert into Have values (297,"Overload");
Insert into Have values (315,"Overload");
Insert into Have values (317,"Overload");
Insert into Have values (318,"Overload");
Insert into Have values (491,"Overload");
Insert into Have values (519,"Overload");
Insert into Have values (555,"Overload");
Insert into Have values (559,"Overload");
Insert into Have values (572,"Overload");
Insert into Have values (664,"Overload");
Insert into Have values (701,"Overload");
Insert into Have values (754,"Overload");
Insert into Have values (8,"Poisonous");
Insert into Have values (178,"Poisonous");
Insert into Have values (242,"Poisonous");
Insert into Have values (262,"Poisonous");
Insert into Have values (313,"Poisonous");
Insert into Have values (340,"Poisonous");
Insert into Have values (368,"Poisonous");
Insert into Have values (431,"Poisonous");
Insert into Have values (463,"Poisonous");
Insert into Have values (495,"Poisonous");
Insert into Have values (616,"Poisonous");
Insert into Have values (617,"Poisonous");
Insert into Have values (620,"Poisonous");
Insert into Have values (672,"Poisonous");
Insert into Have values (683,"Poisonous");
Insert into Have values (684,"Poisonous");
Insert into Have values (694,"Poisonous");
Insert into Have values (737,"Poisonous");
Insert into Have values (20,"Quest");
Insert into Have values (21,"Quest");
Insert into Have values (22,"Quest");
Insert into Have values (23,"Quest");
Insert into Have values (24,"Quest");
Insert into Have values (25,"Quest");
Insert into Have values (26,"Quest");
Insert into Have values (27,"Quest");
Insert into Have values (28,"Quest");
Insert into Have values (12,"Recruit");
Insert into Have values (41,"Recruit");
Insert into Have values (52,"Recruit");
Insert into Have values (149,"Recruit");
Insert into Have values (153,"Recruit");
Insert into Have values (189,"Recruit");
Insert into Have values (268,"Recruit");
Insert into Have values (281,"Recruit");
Insert into Have values (349,"Recruit");
Insert into Have values (357,"Recruit");
Insert into Have values (379,"Recruit");
Insert into Have values (405,"Recruit");
Insert into Have values (500,"Recruit");
Insert into Have values (560,"Recruit");
Insert into Have values (583,"Recruit");
Insert into Have values (606,"Recruit");
Insert into Have values (714,"Recruit");
Insert into Have values (66,"Rush");
Insert into Have values (89,"Rush");
Insert into Have values (99,"Rush");
Insert into Have values (225,"Rush");
Insert into Have values (250,"Rush");
Insert into Have values (266,"Rush");
Insert into Have values (348,"Rush");
Insert into Have values (358,"Rush");
Insert into Have values (408,"Rush");
Insert into Have values (414,"Rush");
Insert into Have values (476,"Rush");
Insert into Have values (492,"Rush");
Insert into Have values (604,"Rush");
Insert into Have values (620,"Rush");
Insert into Have values (645,"Rush");
Insert into Have values (665,"Rush");
Insert into Have values (688,"Rush");
Insert into Have values (719,"Rush");
Insert into Have values (741,"Rush");
Insert into Have values (102,"Secret");
Insert into Have values (134,"Secret");
Insert into Have values (162,"Secret");
Insert into Have values (172,"Secret");
Insert into Have values (175,"Secret");
Insert into Have values (177,"Secret");
Insert into Have values (181,"Secret");
Insert into Have values (222,"Secret");
Insert into Have values (229,"Secret");
Insert into Have values (270,"Secret");
Insert into Have values (293,"Secret");
Insert into Have values (311,"Secret");
Insert into Have values (314,"Secret");
Insert into Have values (319,"Secret");
Insert into Have values (324,"Secret");
Insert into Have values (334,"Secret");
Insert into Have values (337,"Secret");
Insert into Have values (340,"Secret");
Insert into Have values (341,"Secret");
Insert into Have values (369,"Secret");
Insert into Have values (388,"Secret");
Insert into Have values (394,"Secret");
Insert into Have values (440,"Secret");
Insert into Have values (488,"Secret");
Insert into Have values (505,"Secret");
Insert into Have values (508,"Secret");
Insert into Have values (510,"Secret");
Insert into Have values (518,"Secret");
Insert into Have values (525,"Secret");
Insert into Have values (528,"Secret");
Insert into Have values (539,"Secret");
Insert into Have values (542,"Secret");
Insert into Have values (554,"Secret");
Insert into Have values (562,"Secret");
Insert into Have values (565,"Secret");
Insert into Have values (566,"Secret");
Insert into Have values (705,"Secret");
Insert into Have values (720,"Secret");
Insert into Have values (304,"Silence");
Insert into Have values (400,"Silence");
Insert into Have values (553,"Silence");
Insert into Have values (571,"Silence");
Insert into Have values (642,"Silence");
Insert into Have values (680,"Silence");
Insert into Have values (40,"Spell Damage");
Insert into Have values (116,"Spell Damage");
Insert into Have values (385,"Spell Damage");
Insert into Have values (580,"Spell Damage");
Insert into Have values (593,"Spell Damage");
Insert into Have values (654,"Spell Damage");
Insert into Have values (735,"Spell Damage");
Insert into Have values (738,"Spell Damage");
Insert into Have values (740,"Spell Damage");
Insert into Have values (856,"Spell Damage");
Insert into Have values (876,"Spell Damage");
Insert into Have values (881,"Spell Damage");
Insert into Have values (896,"Spell Damage");
Insert into Have values (4,"Stealth");
Insert into Have values (262,"Stealth");
Insert into Have values (334,"Stealth");
Insert into Have values (351,"Stealth");
Insert into Have values (407,"Stealth");
Insert into Have values (415,"Stealth");
Insert into Have values (430,"Stealth");
Insert into Have values (592,"Stealth");
Insert into Have values (613,"Stealth");
Insert into Have values (641,"Stealth");
Insert into Have values (672,"Stealth");
Insert into Have values (681,"Stealth");
Insert into Have values (751,"Stealth");
Insert into Have values (771,"Stealth");
Insert into Have values (772,"Stealth");
Insert into Have values (8,"Taunt");
Insert into Have values (21,"Taunt");
Insert into Have values (34,"Taunt");
Insert into Have values (36,"Taunt");
Insert into Have values (44,"Taunt");
Insert into Have values (47,"Taunt");
Insert into Have values (59,"Taunt");
Insert into Have values (60,"Taunt");
Insert into Have values (77,"Taunt");
Insert into Have values (81,"Taunt");
Insert into Have values (82,"Taunt");
Insert into Have values (84,"Taunt");
Insert into Have values (101,"Taunt");
Insert into Have values (149,"Taunt");
Insert into Have values (190,"Taunt");
Insert into Have values (191,"Taunt");
Insert into Have values (194,"Taunt");
Insert into Have values (199,"Taunt");
Insert into Have values (204,"Taunt");
Insert into Have values (220,"Taunt");
Insert into Have values (224,"Taunt");
Insert into Have values (232,"Taunt");
Insert into Have values (241,"Taunt");
Insert into Have values (259,"Taunt");
Insert into Have values (285,"Taunt");
Insert into Have values (286,"Taunt");
Insert into Have values (315,"Taunt");
Insert into Have values (335,"Taunt");
Insert into Have values (349,"Taunt");
Insert into Have values (361,"Taunt");
Insert into Have values (364,"Taunt");
Insert into Have values (365,"Taunt");
Insert into Have values (366,"Taunt");
Insert into Have values (375,"Taunt");
Insert into Have values (383,"Taunt");
Insert into Have values (384,"Taunt");
Insert into Have values (390,"Taunt");
Insert into Have values (398,"Taunt");
Insert into Have values (413,"Taunt");
Insert into Have values (415,"Taunt");
Insert into Have values (417,"Taunt");
Insert into Have values (419,"Taunt");
Insert into Have values (432,"Taunt");
Insert into Have values (442,"Taunt");
Insert into Have values (448,"Taunt");
Insert into Have values (449,"Taunt");
Insert into Have values (454,"Taunt");
Insert into Have values (461,"Taunt");
Insert into Have values (463,"Taunt");
Insert into Have values (478,"Taunt");
Insert into Have values (509,"Taunt");
Insert into Have values (574,"Taunt");
Insert into Have values (575,"Taunt");
Insert into Have values (576,"Taunt");
Insert into Have values (581,"Taunt");
Insert into Have values (585,"Taunt");
Insert into Have values (586,"Taunt");
Insert into Have values (588,"Taunt");
Insert into Have values (590,"Taunt");
Insert into Have values (601,"Taunt");
Insert into Have values (602,"Taunt");
Insert into Have values (605,"Taunt");
Insert into Have values (607,"Taunt");
Insert into Have values (609,"Taunt");
Insert into Have values (615,"Taunt");
Insert into Have values (616,"Taunt");
Insert into Have values (627,"Taunt");
Insert into Have values (628,"Taunt");
Insert into Have values (633,"Taunt");
Insert into Have values (634,"Taunt");
Insert into Have values (636,"Taunt");
Insert into Have values (643,"Taunt");
Insert into Have values (646,"Taunt");
Insert into Have values (647,"Taunt");
Insert into Have values (660,"Taunt");
Insert into Have values (664,"Taunt");
Insert into Have values (665,"Taunt");
Insert into Have values (676,"Taunt");
Insert into Have values (696,"Taunt");
Insert into Have values (697,"Taunt");
Insert into Have values (737,"Taunt");
Insert into Have values (743,"Taunt");
Insert into Have values (763,"Taunt");
Insert into Have values (765,"Taunt");
Insert into Have values (769,"Taunt");
Insert into Have values (770,"Taunt");
Insert into Have values (795,"Taunt");
Insert into Have values (817,"Taunt");
Insert into Have values (838,"Taunt");
Insert into Have values (845,"Taunt");
Insert into Have values (851,"Taunt");
Insert into Have values (860,"Taunt");
Insert into Have values (862,"Taunt");
Insert into Have values (873,"Taunt");
Insert into Have values (877,"Taunt");
Insert into Have values (883,"Taunt");
Insert into Have values (888,"Taunt");
Insert into Have values (895,"Taunt");
Insert into Have values (902,"Taunt");
Insert into Have values (908,"Taunt");
Insert into Have values (47,"Windfury");
Insert into Have values (126,"Windfury");
Insert into Have values (232,"Windfury");
Insert into Have values (584,"Windfury");
Insert into Have values (595,"Windfury");
Insert into Have values (689,"Windfury");
Insert into Have values (698,"Windfury");
Insert into Have values (754,"Windfury");
Insert into Have values (774,"Windfury");
Insert into Have values (824,"Windfury");
Insert into Have values (880,"Windfury");

/* Actualización para los valores NULL */
SET SQL_SAFE_UPDATES = 0; /* Desactivado de safe update mode */

update card
	set descriptionCard = NULL
where codCard in (573, 753, 775, 776, 777, 778, 780, 781, 852, 855, 857, 870, 875, 884, 892, 899, 904);

update mechanic
	set descriptionMechanic = NULL
where codMechanic = "Choose One";


/* Vistas */

/* Vista del mazo*/
drop view if exists v_deck; 
create view v_deck as select nameCard, Heroe, Rarity, count(*) as 'Number' from deck group by nameCard;


/* Vista de las expansiones de cada carta*/
drop view if exists v_cardexpansion;
create view v_cardexpansion as select distinct nameCard, nameExpansion from card inner join expansion where card_codExpansion = codExpansion;

/* Procedimientos */

delimiter $$

/* Procedimiento para insertar cartas */
drop procedure if exists p_insertaCard $$
create procedure p_insertaCard(
	in par_nameCard varchar(50), 
	in par_rarity varchar(20), 
	in par_type varchar(30), 
	in par_cost smallint(50), 
	in par_damage smallint(50), 
	in par_health smallint(50), 
	in par_descriptionCard varchar(150), 
	in par_card_codExpansion int(11),
    in par_play_codHeroe varchar(20))
begin
	insert into card values (NULL, par_nameCard, par_rarity, par_type, par_cost, par_damage, par_health, par_descriptionCard, par_card_codExpansion);
    insert into play values (par_play_codHeroe, (select codCard from card where nameCard = par_nameCard));
end; $$


/* Filtro legendarias del mazo */
drop procedure if exists p_legendaryFilter $$
create procedure p_legendaryFilter()
begin
	create view v_legendariasrepetidas as select count(*) from deck where Rarity like 'Legendary' group by nameCard having count(*) > 1;
if (select count(*) from v_legendariasrepetidas)>= 1 then truncate table deck;
end if;
drop view v_legendariasrepetidas;
end; $$


/* Filtro contador de cartas repetidas del mazo */
drop procedure if exists p_counter $$
create procedure p_counter()
begin
	create view v_conter as select count(*) from deck group by nameCard having count(*) > 2;
if (select count(*) from v_conter)>= 1 then truncate table deck;
end if;
drop view v_conter;
end; $$


set max_sp_recursion_depth=255 $$ /* Cambio del limite de recursividad */

/* Procedimiento que genera un mazo aleatorio */
drop procedure if exists p_createdeck $$
create procedure p_createdeck(in par_codHeroe varchar(20))
begin

	declare par_contador smallint unsigned default 0;
    declare par_nameCard varchar(50);
    declare par_codCard int;
    
    truncate table deck;
		while par_contador < 30 do /* Crea el mazo */
			set par_codCard = floor((select count(*) from Card) * rand()); /* Selecciona la carta*/
			/* Limitador de Clase */
			if ((select play_codHeroe from play where play_codCard = par_codCard) = par_codHeroe) or 
			((select play_codHeroe from play where play_codCard = par_codCard) = "Everyone") then
			/* Fin limitador de clase */
				set par_nameCard = (select nameCard from Card where codCard = par_codCard);/* Establece el nombre */
				insert into deck values (
					par_codCard,
					par_nameCard,
					(select play_codHeroe from play where play_codCard = par_codCard),
					(select rarity from card where par_codCard = codCard) );
				set par_contador = par_contador +1;
			end if;
		end while;
	/* Filtros*/
	call p_counter();
    call p_legendaryFilter(); 
    if (select count(*) from deck) = 0 then call p_createdeck(par_codHeroe);
	end if;
	/* Fin de filtros*/
end; $$


/* Procedimiento que cambia el nombre de un heroe */
drop procedure if exists p_beaheroe $$
create procedure p_beaheroe(in par_nameHeroe varchar(20), in par_classHeroe varchar (20))
begin

	declare par_randomClass smallint unsigned default 0;
	
    if 
		par_classHeroe like '' or
        par_classHeroe like 'Aleatorio'
	then
		while par_randomClass= 0 do
			set par_randomClass = floor(9 * rand());
		end while;
		case par_randomClass
			when 1 then set par_classHeroe = "Druid";
			when 2 then set par_classHeroe = "Hunter";
			when 3 then set par_classHeroe = "Mage";
			when 4 then set par_classHeroe = "Paladin";
			when 5 then set par_classHeroe = "Priest";
			when 6 then set par_classHeroe = "Rogue";
			when 7 then set par_classHeroe = "Shaman";
			when 8 then set par_classHeroe = "Warlock";
			when 9 then set par_classHeroe = "Warrior";
		end case;
	end if;
	update heroe set nameHeroe = par_nameHeroe
		where codHeroe = par_classHeroe;

end; $$


/* Procedimiento que actualiza la vista del mazo*/
drop procedure if exists p_updateVDeck $$
create procedure p_updateVDeck()
begin
	drop view if exists v_deck;
	create view v_deck as select nameCard, Heroe, Rarity, count(*) as 'Number' from deck group by nameCard;
end; $$


/* Evento que vacia el mazo cada semana */
create event ev_DelBackupCard
on schedule every 1 week
do truncate deck $$


/* Funciones */

SET GLOBAL log_bin_trust_function_creators = 1 $$ /* Permisos para crear funciones */

/* Funcion que calcula la media del coste de mana del mazo */
drop function if exists f_AvgManaCostDeck $$
create function f_AvgManaCostDeck()
	returns smallint(50)
begin

	declare avgcost smallint(50);
    
    set avgcost = (select floor(avg(cost)) from card inner join deck where codCard = deck_codCard);
	return avgcost;
end; $$	


/* Funcion que cuenta el numero de legendarias que existen */
drop function if exists f_countLegendary $$
create function f_countLegendary()
	returns smallint(100)
begin

	declare counter smallint(100);
    
    set counter = (select count(*) from card where rarity like 'Legendary');
	return counter;
end; $$	


/* Funcion que indica la clase del mazo */
drop function if exists f_heroeDeck $$
create function f_heroeDeck()
	returns varchar(50)
begin

	declare heroeDeck varchar(50);
    
    set heroeDeck = (select distinct Heroe from deck where Heroe not like 'Everyone');
    return heroeDeck;
end; $$


/* Funcion que cuenta el numero de expansiones existentes */
drop function if exists f_expansion $$
create function f_expansion()
	returns smallint(20)
begin

	declare counter smallint(100);
    
    set counter = (select count(*) from expansion where nameExpansion not like 'Classic');
	return counter;
end; $$


/* Funcion que cuenta el numero de heroes */
drop function if exists f_heroe $$
create function f_heroe()
	returns smallint(20)
begin

	declare counter smallint(100);
    
    set counter = (select count(*) from heroe where codHeroe not like 'Everyone');
	return counter;
end; $$

/* Disparadores */

/* Disparador que cambia las descripciones vacias a NULL */
drop trigger if exists t_nullDescriptionCard $$
create trigger t_nullDescriptionCard 
	before insert on card for each row 
		if new.descriptionCard like '' then set new.descriptionCard = NULL; 
        end if; 
$$


/* Disparador que se asegura de que el mazo esta bien creado */
drop trigger if exists t_deck $$
create trigger t_deck 
	before update on deck for each row 
    call p_legendaryFilter();
    call p_counter();
$$


/* Creador de mazos */
drop trigger if exists t_deckmaker; $$
create trigger t_deckmaker 
	before delete on deck for each row 
		begin
		
        declare par_randomClass smallint unsigned default 0;
		declare par_classHeroe varchar (20);
        
        if (select count(*) from deck) = 0 then
			while par_randomClass= 0 do
				set par_randomClass = floor(9 * rand());
			end while;
			case par_randomClass
				when 1 then set par_classHeroe = "Druid";
				when 2 then set par_classHeroe = "Hunter";
				when 3 then set par_classHeroe = "Mage";
				when 4 then set par_classHeroe = "Paladin";
				when 5 then set par_classHeroe = "Priest";
				when 6 then set par_classHeroe = "Rogue";
				when 7 then set par_classHeroe = "Shaman";
				when 8 then set par_classHeroe = "Warlock";
				when 9 then set par_classHeroe = "Warrior";
			end case;
			call p_createdeck(par_classHeroe);
		end if;
    end;
        $$


/* Disparador que solo permite insertar heroes de las clases existentes */
drop trigger if exists t_heroeLimiter $$ 
create trigger t_heroeLimiter 
	after insert on heroe for each row 
		if 
			new.codHeroe not like 'Druid' or
			new.codHeroe not like 'Hunter' or
			new.codHeroe not like 'Mage' or
			new.codHeroe not like 'Paladin' or
			new.codHeroe not like 'Priest' or
			new.codHeroe not like 'Rogue' or
			new.codHeroe not like 'Shaman' or
			new.codHeroe not like 'Warlock' or
			new.codHeroe not like 'Warrior' 
		then delete from heroe where codHeroe = new.codHeroe;
    end if;
	$$
 
 
/* Disparador que actualiza la vista del mazo */
drop trigger if exists t_updateVDeck $$
create trigger t_updateVDeck
	before update on deck for each row 
	call p_updateVDeck();
$$

delimiter ;
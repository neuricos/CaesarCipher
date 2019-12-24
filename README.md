# CaesarCipher

This is ruby implementation of the classic caesar cipher. Cipher text is rotated forward from the plain text.

## Example Usage

### Encryption

*plain text:*

```
If he had anything confidential to say, he wrote it in cipher, that is, by so changing the order of the letters of the alphabet, that not a word could be made out. 
```

To encrypt with shift=7, use the following command:

```bash
$ ruby caesar.rb -e -s 7 'If he had anything confidential to say, he wrote it in cipher, that is, by so changing the order of the letters of the alphabet, that not a word could be made out.'

```

*cipher text:*

```
Pm ol ohk hufaopun jvumpkluaphs av zhf, ol dyval pa pu jpwoly, aoha pz, if zv johunpun aol vykly vm aol slaalyz vm aol hswohila, aoha uva h dvyk jvbsk il thkl vba.
```

### Decryption

*cipher text:*

```
Pm ol ohk hufaopun jvumpkluaphs av zhf, ol dyval pa pu jpwoly, aoha pz, if zv johunpun aol vykly vm aol slaalyz vm aol hswohila, aoha uva h dvyk jvbsk il thkl vba.
```

To decrypt this message with shift=7, use the following command:

```bash
$ ruby caesar.rb -d -s 7 'Pm ol ohk hufaopun jvumpkluaphs av zhf, ol dyval pa pu jpwoly, aoha pz, if zv johunpun aol vykly vm aol slaalyz vm aol hswohila, aoha uva h dvyk jvbsk il thkl vba.'
```

This should give back the original message:

*plain text:*

```
If he had anything confidential to say, he wrote it in cipher, that is, by so changing the order of the letters of the alphabet, that not a word could be made out.
```

### Special Characters

To include the encryption/decryption of special characters, use the `-i` option.

For example, to decrypt the encrypted url `lxxt>33{{{2ksskpi2gsq`, use the following command:

```bash
$ ruby caesar.rb -d -s 4 -i 'lxxt>33{{{2ksskpi2gsq'
```

which should give us the plain text url: `http://www.google.com`.

### File Option

You can also use `-f` option and give a file name to the program to encrypt/decrypt the file content.


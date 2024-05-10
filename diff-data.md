# Test difference result

- [Test difference result](#test-difference-result)
  - [With python-generated sin](#with-python-generated-sin)
    - [Amplitude=4e-5](#amplitude4e-5)
    - [Amplitude=40](#amplitude40)
  - [With each of their own sin](#with-each-of-their-own-sin)
    - [Amplitide=40](#amplitide40)

## With python-generated sin

### Amplitude=4e-5

```text
RMSE between C data and Python data = 
        2.6308793111064906e-17
RMSE between C data and Fortran data = 
        3.047825029573996e-17
RMSE between Fortran data and Python data = 
        5.678704340680486e-17
```

### Amplitude=40

```text
RMSE between C data and Python data = 
        2.630879311102846e-11
RMSE between C data and Fortran data = 
        3.0478250295775933e-11
RMSE between Fortran data and Python data = 
        5.678704340680446e-11
```

## With each of their own sin

### Amplitide=40

```test
RMSE between C data and Python data = 
        2.6308852693034814e-11
RMSE between C data and Fortran data = 
        3.047722450701775e-11
RMSE between Fortran data and Python data = 
        5.6786077200052864e-11
```


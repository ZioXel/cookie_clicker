# Cookie Clicker

## 1. Struktura systemu

### Aplikacja

Aplikacja „Cookie Clicker” składa się z dwóch głównych komponentów:
- **Frontend**: Napisany w Flutterze, umożliwia użytkownikom interakcję z grą.
- **Backend**: Napisany w FastAPI, obsługuje logikę gry, przechowywanie stanu i komunikację z frontendem.

### Główne funkcje aplikacji
- **Klikanie**: Zwiększa liczbę ciasteczek.
- **Ulepszenia**: Zwiększają wartość kliknięcia kosztem ciasteczek.
- **Fabryki**: Automatycznie produkują ciasteczka.

---

## 2. Scenariusze testów

### Testy jednostkowe

#### Backend
Testy funkcji obsługujących logikę gry w FastAPI:
1. **Test funkcji click**:
   - Sprawdza, czy liczba ciasteczek zwiększa się o wartość kliknięcia.
2. **Test funkcji upgrade**:
   - Sprawdza, czy wartość kliknięcia i koszt ulepszenia są poprawnie aktualizowane.
3. **Test funkcji buy_basic_factory**:
   - Sprawdza, czy podstawowa fabryka jest poprawnie dodawana do stanu i liczba ciasteczek jest zmniejszana.
4. **Test funkcji buy_advanced_factory**:
   - Sprawdza, czy zaawansowana fabryka jest poprawnie dodawana do stanu i liczba ciasteczek jest zmniejszana.
5. **Test funkcji reset_game**:
   - Sprawdza, czy stan gry jest resetowany.

#### Frontend
Testy funkcji w aplikacji Flutter:
1. **Test funkcji _click**:
   - Sprawdza, czy po kliknięciu liczba ciasteczek jest aktualizowana.
2. **Test funkcji _upgrade**:
   - Sprawdza, czy po ulepszeniu wartość kliknięcia i koszt ulepszenia są aktualizowane.
3. **Test funkcji _buyBasicFactory**:
   - Sprawdza, czy po zakupie podstawowej fabryki jest ona dodawana do listy fabryk.
4. **Test funkcji _buyAdvancedFactory**:
   - Sprawdza, czy po zakupie zaawansowanej fabryki jest ona dodawana do listy fabryk.

### Testy integracyjne
1. **Test komunikacji między frontendem a backendem**:
   - Sprawdza, czy frontend poprawnie komunikuje się z backendem, np. czy kliknięcia są poprawnie przetwarzane przez serwer.
2. **Test synchronizacji stanu gry**:
   - Sprawdza, czy stan gry na froncie jest zgodny z backendem, np. po zakupie fabryki na frontendzie liczba ciasteczek na backendzie jest aktualizowana.

### Testy akceptacyjne
1. **Scenariusz 1: Klikanie i zwiększanie liczby ciasteczek**:
   - Użytkownik klika przycisk „Click!” i sprawdza, czy liczba ciasteczek się zwiększa.
2. **Scenariusz 2: Ulepszanie wartości kliknięcia**:
   - Użytkownik klika przycisk „Upgrade” i sprawdza, czy wartość kliknięcia się zwiększa oraz czy liczba ciasteczek jest odpowiednio zmniejszana.
3. **Scenariusz 3: Zakup fabryk**:
   - Użytkownik kupuje podstawową i zaawansowaną fabrykę, sprawdza, czy liczba ciasteczek jest odpowiednio zmniejszana oraz czy fabryki są dodawane do listy.

---

## 3. Wykorzystane narzędzia i biblioteki

### Backend
- **FastAPI**: Framework do budowy API.
- **Pydantic**: Walidacja danych.
- **Uvicorn**: Serwer ASGI.

### Frontend
- **Flutter**: Framework do budowy aplikacji mobilnych.

### Testy
- **pytest**: Framework do testowania w Pythonie (backend).
- **flutter_test**: Biblioteka do testowania w Flutterze.

---

## 4. Problemy i ich rozwiązania

### Problemy

1. **Problem**: Problemy z komunikacją między Flutter a FastAPI.
   - **Rozwiązanie**: Sprawdź konfigurację CORS i upewnij się, że adresy URL są prawidłowe.

2. **Problem**: Błędy synchronizacji stanu.
   - **Rozwiązanie**: Używaj setState w Flutterze, aby upewnić się, że stan aplikacji jest aktualizowany po każdej interakcji.

3. **Problem**: Opóźnienia w komunikacji.
   - **Rozwiązanie**: Użyj narzędzi do debugowania sieci, aby zidentyfikować i naprawić problemy z opóźnieniami.

### Podsumowanie

Dzięki tej dokumentacji możesz zintegrować testy jednostkowe, integracyjne i akceptacyjne z aplikacją „Cookie Clicker”, co zapewni lepszą jakość i stabilność oprogramowania.

---

### Raporty i pliki

- `report.html`: Wynik testu jednostkowego w Pythonie.
- `test_results.txt`: Wyniki testu jednostkowego w Dart/Flutter.
- `test_result_integration.txt`: Wyniki testu integracyjnego Flutter-Flutter.

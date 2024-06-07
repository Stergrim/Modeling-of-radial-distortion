# Моделирование радиальной дисторсии на цифровых изображениях <br> (Modeling of radial distortion on digital images)

В репозитории представлено моделирование радиальной дисторсии на цифровых изображениях.
Вычисляется только осесимметричная дисторсия третьего порядка, т.к. на практике более высокие порядки наблюдаются редко.

## Каталоги в этом репозитории

>**demos**: папка, содержащая демонстрацию работы предложенного решения <br>
>**matlab**: папка, содержащая код программы

## Запуск

Запуск осуществляется функцией `Distorsion`: <br>
<br>
`NewImage = Distorsion(sourceImage,factor,autoCrop,backgroundColor,save)`<br>
<br>
где **sourceImage** – ссылка на обрабатываемое изображение, например: `Test1.jpg`;<br>
**factor** – величина дисторсии;<br>
**autoCrop** –  вкл/выкл автоматическую обрезку изображения;<br>
**backgroundColor** –  опредление цвета фона в RGB, если не выполнена автоматическая обрезка;<br>
**save** –  вкл/выкл сохранение результата в jpg.

## Примеры

Примеры влияния аберрации дисторсия на изображения и коррекции дисторсии с различной амплитудой искажений на рисунках ниже.<br>
На рисунке справа представлена демонстрация коррекции дисторсии с помощью применения аберрации дисторсия
с противоположной по знаку и одинаковой по модулю величиной к искажённым изображениям.
Проблема масштабирования изображения решалась следующим образом: сначала применяется дисторсия с
автоматической обрезкой, а для коррекции применяется дисторсия с противоположным знаком без обрезки изображения.

<p float="left">
<img src="demos/01.jpg" width="330" />
<img src="demos/02.jpg" width="305" /> 
</p>

**Левый рисунок**<br>
**а** и **б** – исходные изображения, чёрно-белое и цветное;<br>
**в** и **г** – коэффициент дисторсии равен **0,15**, без автоматической обрезки изображения;<br>
**д** и **е** – коэффициент дисторсии равен **-0,30**, без автоматической обрезки изображения;<br>
**ж** – коэффициент дисторсии равен **0,30**;<br>
**з** – коэффициент дисторсии равен **-0,30**.<br>
**Правый рисунок**<br>
**а** и **б** – коэффициент дисторсии **0,15**;<br>
**в** и **г** – коэффициент дисторсии равен **-0,15**;<br>
**д** и **е** – коэффициент дисторсии равен **0,50**;<br>
**ж** и **з** – коэффициент дисторсии равен **-0,35**.<br>

## Замечания

Эта программа является интерпретацией кода, с некоторыми изменениями, из C# в Matlab, который указан по ссылке ниже.<br>
https://www.helviojunior.com.br/fotografia/barrel-and-pincushion-distortion/

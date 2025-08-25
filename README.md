# 33cursoDeIntroduccionAlTestingConJavaScript

Este proyecto es un **curso completo de testing en JavaScript** que te enseña diferentes niveles y tipos de pruebas. Aquí te explico qué puedes hacer con cada parte:

## 📚 **Demos** - Fundamentos de Testing
- **Aprender Jest básico**: Funciones, assertions, setup/teardown
- **Practicar TDD**: Escribir tests antes que el código
- **Entender ESLint**: Calidad de código y buenas prácticas

## 🔧 **Examples/API** - Testing de Backend
- **API REST con Express**: CRUD de libros
- **Tests unitarios**: Servicios y lógica de negocio
- **Tests de integración**: Base de datos real con MongoDB
- **Tests E2E**: Flujo completo de la aplicación

## 🌐 **Webapp** - Testing de Frontend
- **Playwright**: Tests de navegador automatizados
- **Tests E2E de UI**: Interacciones de usuario reales

## 🎯 **Para qué te sirve:**

### **Si eres principiante:**
- Aprende testing desde cero
- Entiende la pirámide de testing
- Practica con ejemplos reales

### **Si ya programas:**
- Mejora la calidad de tu código
- Aprende mejores prácticas
- Implementa CI/CD en tus proyectos

### **Para tu carrera:**
- **Skill muy demandado**: Las empresas buscan devs que sepan testing
- **Código más confiable**: Menos bugs en producción
- **Refactoring seguro**: Cambiar código sin miedo

### **Proyectos reales donde aplicarlo:**
- Cualquier API o web app
- Microservicios
- Aplicaciones críticas

## 🚀 **Cómo usar este proyecto:**

### **Configuración inicial:**
```bash
# Instalar dependencias en cada proyecto
cd demos && npm install
cd ../examples/api && npm install
cd ../webapp && npm install

# Iniciar MongoDB (para tests E2E)
cd examples/api
docker compose up -d
```

### **Ejecutar tests:**
```bash
# Tests básicos de Jest
cd demos && npm test

# Tests unitarios de API
cd examples/api && npm test

# Tests E2E de API
cd examples/api && npm run test:e2e

# Tests de Playwright
cd webapp && npm test
```

## 📁 **Estructura del Proyecto:**

```
📦 33cursoDeIntroduccionAlTestingConJavaScript/
├── 📂 demos/                          # 📚 Fundamentos de Testing
│   ├── src/
│   │   ├── 01-sum.js                  # Función básica para sumar
│   │   ├── 01-sum.test.js             # Tests de la función suma
│   │   ├── 02-math.js                 # Operaciones matemáticas
│   │   ├── 02-math.test.js            # Tests de matemáticas
│   │   ├── 03-lint.js                 # Ejemplo de ESLint
│   │   ├── 04-assertions.test.js      # Diferentes tipos de assertions
│   │   ├── 05-setup.test.js           # beforeAll, beforeEach, etc.
│   │   ├── 06-person.js               # Clase Person
│   │   └── 06-person.test.js          # Tests de la clase Person
│   ├── package.json                   # Jest, Babel, ESLint
│   ├── babel.config.js                # Configuración de Babel
│   └── eslint.config.mjs              # Configuración de ESLint
│
├── 📂 examples/api/                   # 🔧 Testing de Backend
│   ├── src/
│   │   ├── app.js                     # Aplicación Express
│   │   ├── index.js                   # Servidor principal
│   │   ├── config/index.js            # Configuración de BD
│   │   ├── routes/books.router.js     # Rutas de libros
│   │   ├── services/books.service.js  # Lógica de negocio
│   │   ├── services/books.service.test.js  # Tests unitarios
│   │   ├── lib/mongo.lib.js           # Conexión a MongoDB
│   │   └── fakes/book.fake.js         # Datos de prueba
│   ├── api/e2e/
│   │   ├── books.e2e.js               # Tests E2E de libros
│   │   ├── hello.e2e.js               # Tests E2E básicos
│   │   └── jes-e2e.json               # Configuración Jest E2E
│   ├── docker-compose.yml             # MongoDB para tests
│   └── package.json                   # Express, MongoDB, Jest, Supertest
│
├── 📂 webapp/                         # 🌐 Testing de Frontend
│   ├── test/example.spec.js           # Tests de Playwright
│   └── package.json                   # Playwright
│
└── README.md                          # Esta documentación
```

## 🛠️ **Cómo implementarlo en tus proyectos:**

### **1. Para proyectos Node.js/Express:**

#### **Configurar Jest y testing básico:**
```bash
npm install --save-dev jest babel-jest @babel/core @babel/preset-env
```

**package.json:**
```json
{
  "scripts": {
    "test": "jest",
    "test:watch": "jest --watch"
  },
  "jest": {
    "transform": {
      "^.+\\.js$": "babel-jest"
    }
  }
}
```

**babel.config.js:**
```javascript
module.exports = {
  presets: ['@babel/preset-env']
}
```

#### **Para APIs con base de datos:**
```bash
npm install --save-dev supertest mongodb-memory-server
```

**Ejemplo de test de API:**
```javascript
const request = require('supertest')
const app = require('../src/app')

describe('Books API', () => {
  test('GET /books should return books', async () => {
    const response = await request(app)
      .get('/books')
      .expect(200)
    
    expect(response.body).toBeInstanceOf(Array)
  })
})
```

### **2. Para proyectos React/Vue:**

#### **Configurar Jest + Testing Library:**
```bash
npm install --save-dev @testing-library/react @testing-library/jest-dom
```

**Ejemplo de test de componente:**
```javascript
import { render, screen } from '@testing-library/react'
import Button from '../Button'

test('renders button with text', () => {
  render(<Button>Click me</Button>)
  expect(screen.getByText('Click me')).toBeInTheDocument()
})
```

### **3. Tests E2E con Playwright:**

#### **Configuración:**
```bash
npm install --save-dev @playwright/test
npx playwright install
```

**playwright.config.js:**
```javascript
module.exports = {
  testDir: './tests',
  use: {
    baseURL: 'http://localhost:3000',
    headless: true
  },
  webServer: {
    command: 'npm start',
    port: 3000
  }
}
```

### **4. Estructura recomendada para cualquier proyecto:**

```
tu-proyecto/
├── src/
│   ├── components/
│   │   ├── Button.js
│   │   └── Button.test.js         # Test unitario junto al componente
│   ├── services/
│   │   ├── api.service.js
│   │   └── api.service.test.js    # Test unitario del servicio
│   └── utils/
│       ├── helpers.js
│       └── helpers.test.js        # Test de utilidades
├── tests/
│   ├── integration/               # Tests de integración
│   └── e2e/                      # Tests end-to-end
├── jest.config.js
└── playwright.config.js
```

## 💡 **Buenas prácticas para implementar:**

### **Pirámide de Testing:**
1. **70% Tests Unitarios**: Rápidos, aislados
2. **20% Tests de Integración**: Componentes juntos
3. **10% Tests E2E**: Flujo completo del usuario

### **Convenciones de naming:**
- **Archivos**: `component.test.js` o `component.spec.js`
- **Describes**: `describe('ComponentName', () => {})`
- **Tests**: `test('should do something when condition', () => {})`

### **Qué testear:**
- ✅ **Lógica de negocio crítica**
- ✅ **Funciones puras**
- ✅ **APIs endpoints**
- ✅ **Componentes con interacción**
- ❌ **Librerías de terceros**
- ❌ **Código trivial (getters/setters)**

### **Scripts útiles para package.json:**
```json
{
  "scripts": {
    "test": "jest",
    "test:watch": "jest --watch",
    "test:coverage": "jest --coverage",
    "test:e2e": "playwright test",
    "test:ci": "jest --ci --coverage --watchAll=false"
  }
}
```

## 🤖 **GitHub Actions - CI/CD:**

Este proyecto incluye un workflow completo de GitHub Actions que ejecuta automáticamente:

### **Jobs configurados:**
- **📚 Demos**: Tests básicos con Jest + ESLint
- **🔧 API Unit Tests**: Tests unitarios de servicios
- **🚀 API E2E Tests**: Tests end-to-end con MongoDB real
- **🌐 Webapp**: Tests de Playwright con navegadores
- **✅ Tests Summary**: Resumen final de resultados

### **Características del CI:**
- ✅ **Node.js 18** con cache optimizado
- ✅ **MongoDB service** para tests E2E
- ✅ **Playwright browsers** preinstalados
- ✅ **Artifacts** de reportes en caso de fallo
- ✅ **Health checks** para base de datos
- ✅ **Summary** visual de resultados

### **Triggers:**
- Push a `main` o `develop`
- Pull requests a `main`

El workflow está en `.github/workflows/ci.yml` y se ejecuta automáticamente en cada push/PR.

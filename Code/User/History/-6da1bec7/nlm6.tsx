import "./App.css";
import { MainPage } from "./components/MainPage";
import ErrorPage from "./errorPage.tsx";
import { createBrowserRouter, RouterProvider } from "react-router-dom";
import { FailuresTable } from "./components/FailuresTable.tsx";
import { useAppSelector } from "./app/hooks.tsx";

function App() {
  const selectedVersion = useAppSelector((state) => state.main.selectedVersion);

  const router = createBrowserRouter([
    {
      path: "/",
      element: <MainPage />,
      errorElement: <ErrorPage />,
      children: [
        {
          path: ":selectedVersion",
          element: <FailuresTable />,
          loader: useAppSelector((state) => state.main.selectedVersion),
        },
      ],
    },
  ]);

  return <RouterProvider router={router} />;
}

export default App;

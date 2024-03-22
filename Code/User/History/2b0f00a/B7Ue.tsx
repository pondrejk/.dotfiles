import React from "react";
import {
  Toolbar,
  ToolbarContent,
  ToolbarItem,
  Bullseye,
  Label,
  Menu,
  MenuContent,
  MenuList,
  MenuItem,
  MenuToggle,
  Popper,
  Pagination,
  EmptyState,
  EmptyStateHeader,
  EmptyStateFooter,
  EmptyStateBody,
  Button,
  ToolbarToggleGroup,
  EmptyStateIcon,
  EmptyStateActions,
  CodeBlock,
  CodeBlockCode,
  Alert,
  AlertActionLink,
} from "@patternfly/react-core";
import {
  Table,
  Thead,
  Tr,
  Th,
  Tbody,
  Td,
  ExpandableRowContent,
} from "@patternfly/react-table";
import SearchIcon from "@patternfly/react-icons/dist/esm/icons/search-icon";
import FilterIcon from "@patternfly/react-icons/dist/esm/icons/filter-icon";
import data2 from "../data/launch_743.json";
import { Cluster } from "./types";

const clusters: Cluster = data2.clusters;

const columnNames = {
  id: "Cluster ID",
  size: "Size",
  message: "Message",
  teams: "Teams",
  importances: "Importances",
};

const teamColors = {
  endeavour: "cyan",
  "phoenix-content": "blue",
  "phoenix-subscriptions": "orange",
  rocket: "purple",
  platform: "gold",
};

type FailuresTableProps = {
  version: string;
};

export const FailuresTable = ({ version }: FailuresTableProps): JSX.Element => {
  // Set up cluster filtering
  const [teamSelection, setTeamSelection] = React.useState("All teams");

  const onFilter = (cluster: Cluster) => {
    const matchesTeamValue =
      getMembersSummary(cluster.testItems)[0][teamSelection] > 0;

    return teamSelection === "All teams" || matchesTeamValue;
  };
  const filteredClusters = clusters.filter(onFilter);

  // Set up team checkbox select
  const [isMenuOpen, setIsMenuOpen] = React.useState<boolean>(false);
  const toggleRef = React.useRef<HTMLButtonElement>(null);
  const menuRef = React.useRef<HTMLDivElement>(null);
  const contaierRef = React.useRef<HTMLDivElement>(null);

  const handleMenuKeys = (event: KeyboardEvent) => {
    if (isMenuOpen && menuRef.current?.contains(event.target as Node)) {
      if (event.key === "Escape" || event.key === "Tab") {
        setIsMenuOpen(!isMenuOpen);
        toggleRef.current?.focus();
      }
    }
  };

  const handleClickOutside = (event: MouseEvent) => {
    if (isMenuOpen && !menuRef.current?.contains(event.target as Node)) {
      setIsMenuOpen(false);
    }
  };

  React.useEffect(() => {
    window.addEventListener("keydown", handleMenuKeys);
    window.addEventListener("click", handleClickOutside);
    return () => {
      window.removeEventListener("keydown", handleMenuKeys);
      window.removeEventListener("click", handleClickOutside);
    };
  }, [isMenuOpen, menuRef]);

  //sorting
  const [activeSortIndex, setActiveSortIndex] = React.useState(0);
  const [activeSortDirection, setActiveSortDirection] = React.useState("desc");
  const getSortableRowValues = (cluster) => {
    const { testItems } = cluster;
    return [testItems.length];
  };
  let sortedClusters = filteredClusters;

  if (activeSortIndex !== null) {
    sortedClusters = filteredClusters.sort((a, b) => {
      const aValue = getSortableRowValues(a)[activeSortIndex];
      const bValue = getSortableRowValues(b)[activeSortIndex];
      if (typeof aValue === "number") {
        if (activeSortDirection === "asc") {
          return aValue - bValue;
        }
        return bValue - aValue;
      } else {
        if (activeSortDirection === "asc") {
          return aValue.localeCompare(bValue);
        }
        return bValue.localeCompare(aValue);
      }
    });
  }

  //set up expanding
  const [areAllExpanded, setAreAllExpanded] = React.useState(false);
  const [collapseAllAriaLabel, setCollapseAllAriaLabel] =
    React.useState("Expand all");
  const [expandedIDs, setExpandedIDs] = React.useState([]);

  React.useEffect(() => {
    const allExpanded = expandedIDs.length === filteredClusters.length;
    setAreAllExpanded(allExpanded);
    setCollapseAllAriaLabel(allExpanded ? "Collapse all" : "Expand all");
  }, [expandedIDs]);

  const setExpanded = (clusterId: number, isExpanding: boolean) => {
    const otherExpandedIDs = expandedIDs.filter((r) => r !== clusterId);
    setExpandedIDs(
      isExpanding ? [...otherExpandedIDs, clusterId] : otherExpandedIDs
    );
  };

  const isExpanded = (clusterId: number) => expandedIDs.includes(clusterId);

  // We want to be able to reference the original data object based on row index. But because an expanded
  // row takes up two row indexes, servers[rowIndex] will not be accurate like it would in a normal table.
  // One solution to this is to create an array of data objects indexed by the displayed row index.

  const onCollapseAll = (_event: any, _rowIndex: number, isOpen: boolean) => {
    setExpandedIDs(
      isOpen ? [...filteredClusters.map((cluster) => cluster.id)] : []
    );
  };

  const getSortParams = (columnIndex) => ({
    sortBy: {
      index: activeSortIndex,
      direction: activeSortDirection,
      defaultDirection: "asc",
    },
    onSort: (_event, index, direction) => {
      setActiveSortIndex(index);
      setActiveSortDirection(direction);
    },
    columnIndex,
  });

  const onionMenuToggleClick = (ev: React.MouseEvent) => {
    ev.stopPropagation(); // Stop handleClickOutside from handling
    setTimeout(() => {
      if (menuRef.current) {
        const firstElement = menuRef.current.querySelector(
          "li > button:not(:disabled)"
        );
        firstElement && (firstElement as HTMLElement).focus();
      }
    }, 0);
    setIsMenuOpen(!isMenuOpen);
  };

  function onMenuSelect(
    event: React.MouseEvent | undefined,
    itemId: string | number | undefined
  ) {
    if (typeof itemId === "undefined") {
      return;
    }

    setTeamSelection(itemId.toString());
    setIsMenuOpen(!isMenuOpen);
  }

  const toggle = (
    <MenuToggle
      ref={toggleRef}
      onClick={onionMenuToggleClick}
      isExpanded={isMenuOpen}
      icon={<FilterIcon />}
      style={
        {
          width: "200px",
        } as React.CSSProperties
      }
    >
      {teamSelection}
    </MenuToggle>
  );

  const menu = (
    <Menu
      ref={menuRef}
      id="same-select-group-ion-menu"
      onSelect={onMenuSelect}
      selected={teamSelection}
    >
      <MenuContent>
        <MenuList>
          <MenuItem itemId="All teams">All teams</MenuItem>
          <MenuItem itemId="endeavour">Endeavour</MenuItem>
          <MenuItem itemId="phoenix-content">Phoenix-content</MenuItem>
          <MenuItem itemId="phoenix-subscriptions">
            Phoenix-subscriptions
          </MenuItem>
          <MenuItem itemId="rocket">Rocket</MenuItem>
          <MenuItem itemId="platform">Platform</MenuItem>
        </MenuList>
      </MenuContent>
    </Menu>
  );

  const itemSelect = (
    <div ref={contaierRef}>
      <Popper
        trigger={toggle}
        triggerRef={toggleRef}
        popper={menu}
        popperRef={menuRef}
        appendTo={contaierRef.current || undefined}
        isVisible={isMenuOpen}
      />
    </div>
  );

  // Set up pagination and toolbar
  const toolbarPagination = (
    <Pagination
      titles={{ paginationAriaLabel: "Same select group pagination" }}
      itemCount={clusters.length}
      perPage={10}
      page={1}
      widgetId="same-select-group-mock-pagination"
      isCompact
    />
  );

  const toolbar = (
    <Toolbar
      id="same-select-group-toolbar"
      clearAllFilters={() => {
        setTeamSelection("All teams");
      }}
    >
      <ToolbarContent>
        <ToolbarToggleGroup toggleIcon={<FilterIcon />} breakpoint="xl">
          <ToolbarItem>{itemSelect}</ToolbarItem>
        </ToolbarToggleGroup>
        <ToolbarItem variant="pagination">{toolbarPagination}</ToolbarItem>
      </ToolbarContent>
    </Toolbar>
  );

  const emptyState = (
    <EmptyState>
      <EmptyStateHeader
        headingLevel="h4"
        titleText="No results found"
        icon={<EmptyStateIcon icon={SearchIcon} />}
      />
      <EmptyStateBody>
        No results match the filter criteria. Clear all filters and try again.
      </EmptyStateBody>
      <EmptyStateFooter>
        <EmptyStateActions>
          <Button
            variant="link"
            onClick={() => {
              setTeamSelection("All teams");
            }}
          >
            Clear all filters
          </Button>
        </EmptyStateActions>
      </EmptyStateFooter>
    </EmptyState>
  );

  function getMembersSummary(members) {
    let teamsDict = {
      endeavour: 0,
      "phoenix-content": 0,
      "phoenix-subscriptions": 0,
      rocket: 0,
      platform: 0,
    };
    let importancesDict = {
      Critical: 0,
      High: 0,
      Medium: 0,
      Low: 0,
    };
    members.map((mem) => {
      mem.attributes.forEach((attr) => {
        if (attr.key == "team") {
          teamsDict[attr.value] += 1;
        }
        if (attr.key == "importance") {
          importancesDict[attr.value] += 1;
        }
      });
    });

    return [teamsDict, importancesDict];
  }

  function buildTeamsList(teams) {
    let teamLabels = Object.keys(teams).map((key) =>
      teams[key] ? (
        <Label color={teamColors[key]}>
          {key} <b>{teams[key]}</b>
        </Label>
      ) : (
        ""
      )
    );
    return teamLabels;
  }

  function buildImportancesList(imps) {
    let impLabels = Object.keys(imps).map((key) =>
      imps[key] ? (
        <Label color="grey" variant="outline">
          {key} <b>{imps[key]}</b>
        </Label>
      ) : (
        ""
      )
    );
    return impLabels;
  }

  //TODO link hostname from params
  function buildFailureList(members: list) {
    const output = members.map((mem) => {
      return (
        <Alert isInline variant="warning" title={mem.name}>
          <AlertActionLink
            component="a"
            target="blank"
            //TODO: put into settings
            href={`https://reportportal-sat-qe.apps.ocp-c1.prod.psi.redhat.com/ui/#satellite6/launches/all/${mem.launchId}/${mem.parent}/${mem.id}/log`}
          >
            View details on Report Portal
          </AlertActionLink>
          <br />
          <>
            {mem.attributes.map((attr) => (
              <span className="pf-v5-u-color-200">
                {attr.key}: {attr.value}
                {" | "}
              </span>
            ))}
          </>
        </Alert>
      );
    });
    return output;
  }

  return (
    <React.Fragment>
      {toolbar}
      <Table aria-label="Selectable table" borders={1}>
        <Thead>
          <Tr>
            <Th
              expand={{
                areAllExpanded: !areAllExpanded,
                collapseAllAriaLabel,
                onToggle: onCollapseAll,
              }}
            ></Th>
            <Th width={50}>{columnNames.message}</Th>
            <Th width={10}>{columnNames.id}</Th>
            <Th width={10} sort={getSortParams(0)}>
              {columnNames.size}
            </Th>
            <Th width={20}>{columnNames.teams}</Th>
            <Th width={10}>{columnNames.importances}</Th>
          </Tr>
        </Thead>
        <Tbody>
          {filteredClusters.length > 0 &&
            filteredClusters.map((cluster, rowIndex) => {
              let membersSummary = getMembersSummary(cluster.testItems);
              return (
                <>
                  <Tr key={cluster.id}>
                    <Td
                      expand={
                        cluster?.id
                          ? {
                              rowIndex: rowIndex,
                              isExpanded: isExpanded(cluster.id),
                              onToggle: () =>
                                setExpanded(
                                  cluster.id,
                                  !isExpanded(cluster.id)
                                ),
                            }
                          : undefined
                      }
                    ></Td>
                    <Td dataLabel={columnNames.message} modifier="truncate">
                      <CodeBlock>
                        <CodeBlockCode>{cluster.message}</CodeBlockCode>
                      </CodeBlock>
                    </Td>
                    <Td dataLabel={columnNames.id} modifier="truncate">
                      {cluster.id}
                    </Td>
                    <Td dataLabel={columnNames.size} modifier="truncate">
                      {cluster.testItems.length}
                    </Td>
                    <Td dataLabel={columnNames.teams}>
                      {buildTeamsList(membersSummary[0])}
                    </Td>
                    <Td dataLabel={columnNames.importances}>
                      <div>{buildImportancesList(membersSummary[1])}</div>
                    </Td>
                  </Tr>
                  <Tr isExpanded={isExpanded(cluster.id)}>
                    <Td></Td>
                    <Td colSpan={4}>
                      <ExpandableRowContent>
                        {buildFailureList(cluster.testItems)}
                      </ExpandableRowContent>
                    </Td>
                  </Tr>
                </>
              );
            })}
          {filteredClusters.length === 0 && (
            <Tr>
              <Td colSpan={8}>
                <Bullseye>{emptyState}</Bullseye>
              </Td>
            </Tr>
          )}
        </Tbody>
      </Table>
    </React.Fragment>
  );
};
